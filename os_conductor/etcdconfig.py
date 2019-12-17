#
# Copyright 2019 Samana Group
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

"""Defines interface to collect configuration 
from etcd server
"""
import etcd.client as eClient
import ConfigParser
import dns.resolver

class ETCDConfig:
    """Class that handles communication with ETCD service
    ETCD data must be structure like:
    <openstack component>/<config file name>/<file section>/<attribute> -> value
    e.g.
    glance-server/glance-api.conf/DEFAULT/debug -> True
    If the data in etcd doesn't conform to this format, AttributeError errors
    will be raised
    
    Attributes can be static strings or can be variables.
    A variable has to conform to the following standard:
    %<GLOBAL|LOCAL>_<attribute path>%
    e.g.
    %GLOBAL_NOVA_DB_NAME% variable value will be stored in etcd as
    /GLOBAL/NOVA/DB/NAME
    if the first section of the variable is LOCAL the information
    is not expected to be stored in ETCD but instead the variable
    should be set using the function set_variable
    """

    def __init__(self, etcd_path, etcd_server="127.0.0.1", etcd_port=2379, domain=None):
        """Initializer will create a child ETCDConfig object that collects
        all the global variables that later will be replaced within the
        configurations.
        It is important that the format of the etcd_path is in the form
        <openstack component>/<config file name>
        e.g.
        glance-server/glance-api.conf
        """
        if domain is not None:
            ans = dns.resolver.query('_etcd-client._tcp.' + domain, 'SRV')
            etcd_server = tuple(((str(x.target), x.port) for x in ans))
            etcd_port = None
        self.path = etcd_path
        self.path_array = etcd_path.split('/')
        if self.path_array[0] == '':
            self.path_array.pop(0)
        self.variables = None
        if self.path_array[0] != 'GLOBAL':
            self.variables = ETCDConfig('GLOBAL', etcd_server, etcd_port)
            self.variables.collect()
        self.e = eClient.Client(etcd_server, etcd_port, allow_reconnect=True)

    def set_variable(self, var_name, value):
        """Sets a global variable.
        This function is used for setting variables specific for servers
        that are not general to the environment. For example the local IP.
        The variable name should be in the form
        LOCAL_<attribute>
        e.g.
        LOCAL_IP"""
        if self.variables is not None:
            self.variables.set(var_name, value)
        else:
            raise AttributeError("Unable to set variable %s" % var_name)

    def collect(self, wait=False):
        """Collects data from etcd"""
        if wait:
            self.e.watch(self.path, recursive=True)
        sections = self.e.read(self.path, recursive=True)
        self._etcd_to_dict(sections)

    def _etcd_to_dict(self, etcdresult):
        """This private function will convert the collection of EtcdResult
        into a dict that holds all the data recursively."""
        self.config = {}
        for s in etcdresult.get_subtree(leaves_only=True):
            current_location = self.config
            key_path = s.key.split('/')
            while len(key_path) > 0:
                kp = key_path.pop(0)
                if kp == '': continue
                if len(key_path) == 0:
                    if self.variables is not None:
                        try:
                            current_location[kp] = self.variables._replace_variables(s.value)
                        except Exception as e:
                            raise AttributeError("Variable %s in attribute %s doesn't exist" 
                                % (str(e), kp))
                    else:
                        current_location[kp] = s.value
                else:
                    if kp not in current_location:
                        current_location[kp] = {}
                    current_location = current_location[kp]

    def get(self, varname):
        """Returns the value of a variable.
        The format of the variable expected is defined in the description
        of the class."""
        path=varname.split('_')
        current_location = self.config
        for p in path:
            if p in current_location:
                current_location = current_location[p]
            else:
                raise AttributeError(varname)
        return current_location
    def set(self, varname, value):
        """Sets the value of a variable.
        The format of the variable expected is defined in the description
        of the class."""
        current_location = self.config
        key_path = varname.split('_')
        while len(key_path) > 0:
            kp = key_path.pop(0)
            if kp == '': continue
            if len(key_path) == 0:
                current_location[kp] = value
            else:
                if kp not in current_location:
                    current_location[kp] = {}
                current_location = current_location[kp]
    def _replace_variables(self, string):
        """This private function will receive a string and will parse for 
        %<variable name>% then, it will look into the global variables 
        defined in this object to replace with the value."""
        out = ""
        var_name = ""
        escape = False
        is_variable = False
        for i in string:
            if i == '%' and escape == False:
                if is_variable:
                    is_variable = False
                    replacement = self.get(var_name)
                    if replacement is not None:
                        out += str(replacement)
                    else:
                        raise AttributeError(var_name)
                else:
                    is_variable = True
                    var_name = ""
            elif i == '\\':
                escape = True
            elif is_variable:
                var_name += i
                escape = False
            else:
                out += i
                escape = False
        if is_variable:
            print "Invalid String (%s)" % string
            return string
        return out
    def data_to_Config(self, Config):
        """This function expects Config to be a ConfigParser object.
        Then, it will travers the config dictionary and creates the necessary
        attributes to generate an INI file."""
        if not isinstance(Config, ConfigParser.ConfigParser):
            raise AttributeError("Invalid input. Expecting ConfigParser.ConfigParser")

        config_data = self.config
        for i in self.path_array:
            if i in config_data:
                config_data = config_data[i]
            else:
                raise AttributeError("Unable to find path in configuration")

        if not isinstance(config_data, dict):
            raise AttributeError("Invalid config. Review etcd configuration")

        for section in config_data:
            if not isinstance(config_data[section], dict):
                raise AttributeError("Invalid config section %s. Review etcd configuration" \
                    % section)

            if section != 'DEFAULT':
                Config.add_section(section)

            for key in config_data[section]:
                if isinstance(config_data[section][key], dict):
                    raise AttributeError("Invalid attribute %s at section %s" % (key, section))
                Config.set(section, key, config_data[section][key])
