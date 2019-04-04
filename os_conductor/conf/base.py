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
from oslo_utils import netutils

base_options = [
    cfg.StrOpt("etcd_server",
        default="127.0.0.1",
        help="""
            Determines the IP address of the ETCD server.
            """),

    cfg.StrOpt("my_ip",
        default=netutils.get_my_ipv4(),
        help="""
            The IP address which the host is using to connect to the management network.

            Possible values:

            * String with valid IP address. Default is IPv4 address of this host.
            """),

    cfg.BoolOpt("daemon",
        default=False,
        help="""
            Determines if OS_Conductor will run as daemon or
            if it will only generate the configuration files.
            """),
# TODO: add certificates needed to access etcd configurations
]

def register_opts(conf):
    conf.register_opts(base_options)

def list_opts():
    return {'DEFAULT': base_options}
