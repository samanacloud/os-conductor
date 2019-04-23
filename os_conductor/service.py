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
import os, stat, signal, pwd, grp
import etcdconfig
import contextlib

LOG = logging.getLogger(__name__)

CONF = os_conductor.conf.CONF

ecfg = None

@contextlib.contextmanager
def write_file(config_file, Config):
    try:
        cfg_file = open(config_file, 'w')
        yield cfg_file
        cfg_file.close()
    except Exception as e:
        LOG.error("Error handling file %s. %s" % (config_file, str(e)))
        exit(1)

def signal_handler(sig, frame):
        LOG.info('Finished processing.')
        sys.exit(0)

def set_file_permissions(section, config_path):
    try:
        uid = pwd.getpwnam(CONF[section].user).pw_uid
        gid = grp.getgrnam(CONF[section].group).gr_gid
        os.chown(config_path, uid, gid)
    except:
        LOG.error("Unable to change permissions of file %s" % config_path)

def child(etcd_path, config_file):
    global ecfg

    Config = ConfigParser.ConfigParser()
    with write_file(config_file, Config) as cfg_file:
        ecfg.collect()
        ecfg.data_to_Config(Config)
        Config.write(cfg_file)

    if not CONF.daemon:
        set_file_permissions(section, config_file)

    LOG.info("Writing file %s from %s" % (
        config_file, 
        CONF.domain if CONF.domain is not None else CONF.etcd_server ))

def create_file(os_component, config_file):
    global ecfg
    config_path = "%s/%s" % (CONF[os_component].config_dir, config_file)
    etcd_path = os_component + "/"
    if CONF[os_component].service_type != "":
        etcd_path += CONF[os_component].service_type + "/"
    etcd_path += config_file
    LOG.info("Searching etcd path %(etcd_path)s", 
        { 'etcd_path': etcd_path} )
    daemon = CONF.daemon

    if os.path.exists(config_path):
        if stat.S_ISFIFO(os.stat(config_path).st_mode):
            os.remove(config_path)
        else:
            os.rename(config_path, config_path + ".bak")

    if daemon:
        try:
            os.mkfifo(config_path)
            set_file_permissions(os_component, config_path)
            LOG.info("Created %s pipe." % config_path)
        except OSError:
            LOG.error("Unable to create pipe %s. Check path." % config_path)
            exit(1)

    try:
        ecfg = etcdconfig.ETCDConfig(etcd_path, etcd_server=CONF.etcd_server, domain=CONF.domain)
        ecfg.set_variable('LOCAL_IP', CONF.my_ip)
        ecfg.collect()
    except Exception as e:
        LOG.error("Unable to generate configuration %s. %s" % (config_file, str(e)))
        exit(1)

    while True:
        child_pid = os.fork()
        if child_pid != 0:
            pid, status = os.waitpid(child_pid, 0)
            if not daemon or status != 0:
                break
        else:
            LOG.info("Waiting for requests to %s pipe/file" % config_path)
            child(etcd_path, config_path)
            break


def process_launcher():
    pid_list = []
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    for section in CONF.list_all_sections():
        if section == 'DEFAULT': continue
        if not CONF[section].enabled: continue
        LOG.info("Starting to handle %s component." % section)
        config_files = CONF[section].config_files.split(',')
        for config_file in config_files:

            pid = os.fork()
            if pid == 0:
                create_file(section, config_file)
                exit(0)
            else:
                pid_list.append(pid)
    if len(pid_list > 0):
        os.waitpid(0, 0)

    if CONF.daemon:
        LOG.info("Sub processes: %s" % pid_list)
    else:
        LOG.info("Finished creating config files")

    return None
