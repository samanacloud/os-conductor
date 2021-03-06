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

glance_group = cfg.OptGroup('glance',
    title='Glance Server options',
    help="""
        Options under this group are used to define Glance configurations.
        """)

glance_options = [
    cfg.BoolOpt("enabled",
        default=False,
        help="""
            Determines if Glance Server configuration file will be handled.
            """),

    cfg.StrOpt("service_type",
        default="server",
        help="""
            Determine type of service for glance configuration files.
            This value determines a sub-section in etcd where specific configuration
            is stored.
            e.g
            service_type=glance_ubuntu
            means that the configuration will be found in etcd in the following path
            /glance/glance_ubuntu/glance-api.conf/(...)

            This parameter allow for different type of glance configurations on 
            the same etcd server.
            """),

    cfg.StrOpt("config_dir",
        default="/etc/glance",
        help="""
            Determine the root path for glance configuration files.
            """),

    cfg.StrOpt("config_files",
        default="",
        help="""
            Coma separated list of configuration files to be generated.
            e.g. glance-api.conf,glance-registry.conf
            """),

    cfg.StrOpt("group",
        default="glance",
        help="""
            Determines the group that will be allowed access to the configuration file.
            """),

    cfg.StrOpt("user",
        default="glance",
        help="""
            Determines the user that will be allowed access to the configuration file.
            """)    
]

def register_opts(conf):
    conf.register_group(glance_group)
    conf.register_opts(glance_options, group=glance_group)

def list_opts():
    return {glance_group: glance_options}
