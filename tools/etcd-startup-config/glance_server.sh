#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

# Glance Configurations

e rm --recursive glance/server/glance-api.conf
e set glance/server/glance-api.conf/DEFAULT/show_image_direct_url True
e set glance/server/glance-api.conf/DEFAULT/show_multiple_locations True
e set glance/server/glance-api.conf/DEFAULT/bind_host %LOCAL_IP%
e set glance/server/glance-api.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set glance/server/glance-api.conf/DEFAULT/registry_host %GLOBAL_GLANCE_REGISTRY_SERVER%
e set glance/server/glance-api.conf/database/connection %GLOBAL_GLANCE_DB_TYPE%://%GLOBAL_GLANCE_DB_USER%:%GLOBAL_GLANCE_DB_PASS%@%GLOBAL_GLANCE_DB_SERVER%/%GLOBAL_GLANCE_DB_NAME%
e set glance/server/glance-api.conf/glance_store/default_store rbd
e set glance/server/glance-api.conf/glance_store/stores file,rbd
e set glance/server/glance-api.conf/glance_store/rbd_store_pool images
e set glance/server/glance-api.conf/glance_store/rbd_store_user images
e set glance/server/glance-api.conf/glance_store/rbd_store_ceph_conf /etc/ceph/ceph.conf
e set glance/server/glance-api.conf/image_format/disk_formats ami,ari,aki,vhd,vhdx,vmdk,raw,qcow2,vdi,iso,ploop.root-tar
e set glance/server/glance-api.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set glance/server/glance-api.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set glance/server/glance-api.conf/keystone_authtoken/auth_type password
e set glance/server/glance-api.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set glance/server/glance-api.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set glance/server/glance-api.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set glance/server/glance-api.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_GLANCE_USER%
e set glance/server/glance-api.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_GLANCE_PASS%
e set glance/server/glance-api.conf/paste_deploy/flavor keystone

e rm --recursive glance/server/glance-registry.conf
e set glance/server/glance-registry.conf/DEFAULT/bind_host %LOCAL_IP%
e set glance/server/glance-registry.conf/database/connection %GLOBAL_GLANCE_DB_TYPE%://%GLOBAL_GLANCE_DB_USER%:%GLOBAL_GLANCE_DB_PASS%@%GLOBAL_GLANCE_DB_SERVER%/%GLOBAL_GLANCE_DB_NAME%
e set glance/server/glance-registry.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set glance/server/glance-registry.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set glance/server/glance-registry.conf/keystone_authtoken/auth_type password
e set glance/server/glance-registry.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set glance/server/glance-registry.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set glance/server/glance-registry.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set glance/server/glance-registry.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_GLANCE_USER%
e set glance/server/glance-registry.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_GLANCE_PASS%
e set glance/server/glance-registry.conf/paste_deploy/flavor keystone

