#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

e set GLOBAL/TRANSPORT/USER openstack
e set GLOBAL/TRANSPORT/PASS Samana81.
e set GLOBAL/TRANSPORT/SERVER os.samana.cloud
e set GLOBAL/TRANSPORT/PORT 5672
e set GLOBAL/TRANSPORT/TYPE rabbit

e set GLOBAL/NOVA/DB/TYPE mysql+pymysql
e set GLOBAL/NOVA/DB/USER nova
e set GLOBAL/NOVA/DB/PASS Samana81.
e set GLOBAL/NOVA/DB/SERVER controller.samana.cloud:3306
e set GLOBAL/NOVA/DB/NAMEAPI nova_api
e set GLOBAL/NOVA/DB/NAME nova
e set GLOBAL/NOVA/METADATA/PASS metadatapass
e set GLOBAL/NOVA/METADATA/HOST os.samana.cloud

e set GLOBAL/GLANCE/REGISTRY/SERVER os.samana.cloud
e set GLOBAL/GLANCE/API/SERVER http://os.samana.cloud:9292
e set GLOBAL/GLANCE/DB/TYPE mysql+pymysql
e set GLOBAL/GLANCE/DB/USER glance
e set GLOBAL/GLANCE/DB/PASS Samana81.
e set GLOBAL/GLANCE/DB/SERVER controller.samana.cloud:3306
e set GLOBAL/GLANCE/DB/NAME glance

e set GLOBAL/CINDER/INTERNAL/TENANT/USER/ID f4baad1e24ad42a0acc4723d9c1fc18f
e set GLOBAL/CINDER/INTERNAL/TENANT/PROJECT/ID d192d47e519049d6b2b1d4690dd5ea13
e set GLOBAL/CINDER/DB/TYPE mysql+pymysql
e set GLOBAL/CINDER/DB/USER cinder
e set GLOBAL/CINDER/DB/PASS Samana81.
e set GLOBAL/CINDER/DB/SERVER controller.samana.cloud:3306
e set GLOBAL/CINDER/DB/NAME cinder

e set GLOBAL/NEUTRON/SERVER os.samana.cloud:9696
e set GLOBAL/NEUTRON/DB/TYPE mysql+pymysql
e set GLOBAL/NEUTRON/DB/USER neutron
e set GLOBAL/NEUTRON/DB/PASS Samana81.
e set GLOBAL/NEUTRON/DB/SERVER controller.samana.cloud:3306
e set GLOBAL/NEUTRON/DB/NAME neutron

e set GLOBAL/MEMCACHED/SERVER os.samana.cloud:11211

e set GLOBAL/KEYSTONE/SERVER os.samana.cloud:5000
e set GLOBAL/KEYSTONE/PUBLICSERVER os.samana.cloud:35357
e set GLOBAL/KEYSTONE/PROJECT/DOMAIN default
e set GLOBAL/KEYSTONE/USER/DOMAIN default
e set GLOBAL/KEYSTONE/PROJECT/NAME service
e set GLOBAL/KEYSTONE/NOVA/USER nova
e set GLOBAL/KEYSTONE/NOVA/PASS Samana81.
e set GLOBAL/KEYSTONE/NEUTRON/USER neutron
e set GLOBAL/KEYSTONE/NEUTRON/PASS Samana81.
e set GLOBAL/KEYSTONE/PLACEMENT/USER placement
e set GLOBAL/KEYSTONE/PLACEMENT/PASS Samana81.
e set GLOBAL/KEYSTONE/GLANCE/USER glance
e set GLOBAL/KEYSTONE/GLANCE/PASS Samana81.
e set GLOBAL/KEYSTONE/CINDER/USER cinder
e set GLOBAL/KEYSTONE/CINDER/PASS Samana81.

e set GLOBAL/RBD/VMPOOL vms
e set GLOBAL/RBD/USER nova
e set GLOBAL/RBD/SECRET/UUID b5ebf8f1-815c-435e-81b0-76cb8c59cb88

e set GLOBAL/NOVNCPROXY/BASE/URL http://admin.samana.cloud:6080/vnc_auto.html

e set GLOBAL/XEN/xen02/HOST xen02
e set GLOBAL/XEN/xen02/USER root
e set GLOBAL/XEN/xen02/PASS Samana81.
