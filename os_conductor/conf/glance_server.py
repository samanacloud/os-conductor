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

glance_server_group = cfg.OptGroup('glance_server',
    title='Glance Server options',
    help="""
        Options under this group are used to define Glance configurations.
        """)

glance_server_options = [
    cfg.BoolOpt("enabled",
        default=False,
        help="""
            Determines if Glance Server configuration file will be handled.
            """),

    cfg.StrOpt("config_dir",
        default="/etc/glance",
        help="""
            Determine the root path for glance configuration files.
            """),

    cfg.StrOpt("api_config_file",
        default="glance-api.conf",
        help="""
            Determine the base configuration file for glance-api.
            """),

    cfg.StrOpt("registry_config_file",
        default="glance-registry.conf",
        help="""
            Determine the base configuration file for glance-registry.
            """)
]

def register_opts(conf):
    conf.register_group(glance_server_group)
    conf.register_opts(glance_server_options, group=glance_server_group)

def list_opts():
    return {glance_server_group: glance_server_options}
