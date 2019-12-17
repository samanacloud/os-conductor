#!/usr/bin/python2.7
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

import ConfigParser
import netifaces as ni
import sys
import os, stat
import etcdconfig

def get_my_ip(device="eth0"):
    return ni.ifaddresses(device)[ni.AF_INET][0]['addr']

def child(etcd_path, config_file, etcd_server, wait=False):
    ecfg = etcdconfig.ETCDConfig(etcd_path, etcd_server)
    ecfg.set_variable('LOCAL_IP', get_my_ip("eth0"))
    ecfg.collect(wait)

    Config = ConfigParser.ConfigParser()
    ecfg.data_to_Config(Config)
    cfg_file = open(config_file, 'w')
    Config.write(cfg_file)
    cfg_file.close()


if __name__ =="__main__":
    #etcd_path='nova-server/nova.conf'
    #config_file='nova.conf'
    #etcd_server="10.255.254.200"
    # -p pipe instead of file (dynamic config)
    if len(sys.argv) < 4 or len(sys.argv) > 5:
        print "USAGE: %s <etcd path> <config_file> <etcd server> [-p]" % sys.argv[0]
        exit(1)
    etcd_path = sys.argv[1]
    config_file = sys.argv[2]
    etcd_server = sys.argv[3]
    pipe = False
    if len(sys.argv) == 5:
        if sys.argv[4] == '-p':
            pipe = True

    if pipe:
        if not os.path.exists(config_file):
            try:
                os.mkfifo(config_file)
            except OSError:
                print "Unable to create pipe. Check path."
                exit(1)
        else:
            if not stat.S_ISFIFO(os.stat(config_file).st_mode):
                print "The path is not a pipe"
                exit(1)
    child(etcd_path, config_file, etcd_server, wait=False)
    wait = not pipe
    while True:
        child_pid = os.fork()
        if child_pid != 0:
            pid, status = os.waitpid(child_pid, 0)
            if not pipe or status != 0:
                break
        else:
            child(etcd_path, config_file, etcd_server, wait=wait)
            break
