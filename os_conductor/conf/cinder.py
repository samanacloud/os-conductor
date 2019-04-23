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

cinder_group = cfg.OptGroup('cinder',
    title='Cinder Server options',
    help="""
        Options under this group are used to define Cinder configurations.
        """)

cinder_options = [
    cfg.BoolOpt("enabled",
        default=False,
        help="""
            Determines if Cinder Server configuration file will be handled.
            """),

    cfg.StrOpt("service_type",
        default="server",
        help="""
            Determine type of service for cinder configuration files.
            This value determines a sub-section in etcd where specific configuration
            is stored.
            e.g
            service_type=compute_xapi
            means that the configuration will be found in etcd in the following path
            /cinder/compute_xapi/cinder.conf/(...)

            This parameter allow for different type of nova configurations on 
            the same etcd server.
            """),

    cfg.StrOpt("config_dir",
        default="/etc/cinder",
        help="""
            Determine the root path for Cinder configuration files.
            """),

    cfg.StrOpt("config_files",
        default="",
        help="""
            Coma separated list of configuration files to be generated.
            e.g. cinder.conf
            """),

    cfg.StrOpt("group",
        default="cinder",
        help="""
            Determines the group that will be allowed access to the configuration file.
            """),

    cfg.StrOpt("user",
        default="cinder",
        help="""
            Determines the user that will be allowed access to the configuration file.
            """)    
]

def register_opts(conf):
    conf.register_group(cinder_group)
    conf.register_opts(cinder_options, group=cinder_group)

def list_opts():
    return {cinder_group: cinder_options}
