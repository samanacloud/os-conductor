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

nova_server_group = cfg.OptGroup('nova_server',
    title='Nova Server options',
    help="""
        Options under this group are used to define Nova configurations.
        """)

nova_server_options = [
    cfg.BoolOpt("enabled",
        default=False,
        help="""
            Determines if Nova Server configuration file will be handled.
            """),

    cfg.StrOpt("config_dir",
        default="/etc/nova",
        help="""
            Determine the root path for nova configuration files.
            """),

    cfg.StrOpt("config_files",
        default="",
        help="""
            Coma separated list of configuration files to be generated.
            """),

    cfg.StrOpt("group",
        default="nova",
        help="""
            Determines the group that will be allowed access to the configuration file.
            """)
]

def register_opts(conf):
    conf.register_group(nova_server_group)
    conf.register_opts(nova_server_options, group=nova_server_group)

def list_opts():
    return {nova_server_group: nova_server_options}
