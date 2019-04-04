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

def get_my_ip(device="eth0"):
    return ni.ifaddresses(device)[ni.AF_INET][0]['addr']

def child(etcd_path, config_file, etcd_server):
    cfg_file = open(config_file, 'w')
    ecfg = etcdconfig.ETCDConfig(etcd_path, etcd_server)
    ecfg.set_variable('LOCAL_IP', get_my_ip("eth0"))
    ecfg.collect()

    Config = ConfigParser.ConfigParser()
    ecfg.data_to_Config(Config)
    Config.write(cfg_file)
    cfg_file.close()

def create_file(section, config_file):
    config_path = "%s/%s" % (CONF[section].config_dir, config_file)
    etcd_path = "%s/%s" % (section, config_file)
    etcd_server = CONF.etcd_server
    daemon = CONF.daemon

    if os.path.exists(config_path):
        os.rename(config_path, config_path + ".bak")

    if daemon:
        try:
            os.mkfifo(config_path)
        except OSError:
            print "Unable to create pipe. Check path."
            exit(1)

    while True:
        child_pid = os.fork()
        if child_pid != 0:
            pid, status = os.waitpid(child_pid, 0)
            if not daemon or status != 0:
                break
        else:
            child(etcd_path, config_path, etcd_server)
            break


def process_launcher():
    pid_list = []
    for section in CONF.list_all_sections():
        if section == 'DEFAULT': continue
        if not CONF[section].enabled: continue
        config_files = CONF[section].config_files.split(',')
        for config_file in config_files:
            pid = os.fork()
            if pid == 0:
                create_file(section, config_file)
                exit(0)
            else:
                pid_list.append(pid)
    if CONF.daemon:
        LOG.info("Sub processes: %s" % pid_list)
    else:
        LOG.info("Finished creating config files")

    return None