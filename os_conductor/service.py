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


import sys

from oslo_log import log as logging
import os_conductor.conf
import ConfigParser
import netifaces as ni
import sys
import os, stat
import etcdconfig

LOG = logging.getLogger(__name__)

CONF = os_conductor.conf.CONF

def process_launcher():
    LOG.info(CONF.list_all_sections())
    if CONF.daemon:
        LOG.info("Daemon")
    else:
        LOG.info("Generate files")
    return None
