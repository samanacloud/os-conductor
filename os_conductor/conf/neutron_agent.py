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

from oslo_config import cfg

neutron_agent_group = cfg.OptGroup('neutron_agent',
    title='Neutron Server options',
    help="""
        Options under this group are used to define Neutron configurations.
        """)

neutron_agent_options = [
    cfg.BoolOpt("enabled",
        default=False,
        help="""
            Determines if Neutron Server configuration file will be handled.
            """),

    cfg.StrOpt("service_type",
        default="",
        help="""
            Determine type of service for neutron configuration files.
            This value determines a sub-section in etcd where specific configuration
            is stored.
            e.g
            service_type=agents
            means that the configuration will be found in etcd in the following path
            /neutron_agent/agents/neutron.conf/(...)

            This parameter allow for different type of nova configurations on 
            the same etcd server.
            """),

    cfg.StrOpt("config_dir",
        default="/etc/neutron",
        help="""
            Determine the root path for Neutron configuration files.
            """),

    cfg.StrOpt("config_files",
        default="",
        help="""
            Coma separated list of configuration files to be generated.
            e.g. neutron.conf,l3_agent.ini
            """),

    cfg.StrOpt("group",
        default="neutron",
        help="""
            Determines the group that will be allowed access to the configuration file.
            """),

    cfg.StrOpt("user",
        default="neutron",
        help="""
            Determines the user that will be allowed access to the configuration file.
            """)    
]

def register_opts(conf):
    conf.register_group(neutron_agent_group)
    conf.register_opts(neutron_agent_options, group=neutron_agent_group)

def list_opts():
    return {neutron_agent_group: neutron_agent_options}
