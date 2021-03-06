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

"""Starter script for OS_Conductor."""

import sys

from oslo_log import log as logging
import os_conductor.conf
from os_conductor import config
from os_conductor import service

CONF = os_conductor.conf.CONF

def main():
    config.parse_args(sys.argv)
    logging.setup(CONF, "os_conductor")
    log = logging.getLogger(__name__)

    launcher = service.process_launcher()
