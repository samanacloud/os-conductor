#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

e rm --recursive cinder/server

e set cinder/server/cinder.conf/DEFAULT/rootwrap_config /etc/cinder/rootwrap.conf
e set cinder/server/cinder.conf/DEFAULT/api_paste_confg /etc/cinder/api-paste.ini
e set cinder/server/cinder.conf/DEFAULT/iscsi_helper tgtadm
e set cinder/server/cinder.conf/DEFAULT/volume_name_template volume-%s
e set cinder/server/cinder.conf/DEFAULT/volume_group cinder-volumes
e set cinder/server/cinder.conf/DEFAULT/auth_strategy keystone
e set cinder/server/cinder.conf/DEFAULT/state_path /var/lib/cinder
e set cinder/server/cinder.conf/DEFAULT/lock_path /var/lock/cinder
e set cinder/server/cinder.conf/DEFAULT/volumes_dir /var/lib/cinder/volumes
e set cinder/server/cinder.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set cinder/server/cinder.conf/DEFAULT/my_ip %LOCAL_IP%
e set cinder/server/cinder.conf/DEFAULT/glance_api_servers %GLOBAL_GLANCE_API_SERVER%
e set cinder/server/cinder.conf/DEFAULT/storage_availability_zone FL1
e set cinder/server/cinder.conf/DEFAULT/default_availability_zone FL1
e set cinder/server/cinder.conf/DEFAULT/allow_availability_zone_fallback True
e set cinder/server/cinder.conf/DEFAULT/cinder_internal_tenant_user_id %GLOBAL_CINDER_INTERNAL_TENANT_USER_ID%
e set cinder/server/cinder.conf/DEFAULT/cinder_internal_tenant_project_id %GLOBAL_CINDER_INTERNAL_TENANT_PROJECT_ID%
e set cinder/server/cinder.conf/DEFAULT/image_volume_cache_enabled True
e set cinder/server/cinder.conf/database/connection %GLOBAL_CINDER_DB_TYPE%://%GLOBAL_CINDER_DB_USER%:%GLOBAL_CINDER_DB_PASS%@%GLOBAL_CINDER_DB_SERVER%/%GLOBAL_CINDER_DB_NAME%
e set cinder/server/cinder.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set cinder/server/cinder.conf/keystone_authtoken/auth_uri http://%GLOBAL_KEYSTONE_SERVER%/v3
e set cinder/server/cinder.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set cinder/server/cinder.conf/keystone_authtoken/auth_type password
e set cinder/server/cinder.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set cinder/server/cinder.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set cinder/server/cinder.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set cinder/server/cinder.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_CINDER_USER%
e set cinder/server/cinder.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_CINDER_PASS%
e set cinder/server/cinder.conf/oslo_concurrency/lock_path /var/lib/cinder/tmp
