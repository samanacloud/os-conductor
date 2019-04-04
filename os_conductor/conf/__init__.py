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

from os_conductor.conf import base
from os_conductor.conf import nova_server
from os_conductor.conf import glance_server

CONF = cfg.CONF

base.register_opts(CONF)
nova_server.register_opts(CONF)
glance_server.register_opts(CONF)