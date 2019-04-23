#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

e rm --recursive nova/server

e set nova/server/nova.conf/DEFAULT/log_dir /var/log/nova
e set nova/server/nova.conf/DEFAULT/lock_path /var/lock/nova
e set nova/server/nova.conf/DEFAULT/state_path /var/lib/nova
e set nova/server/nova.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set nova/server/nova.conf/DEFAULT/my_ip %LOCAL_IP%
e set nova/server/nova.conf/DEFAULT/disk_allocation_ratio 2.0
e set nova/server/nova.conf/DEFAULT/metadata_workers 2
e set nova/server/nova.conf/DEFAULT/osapi_compute_workers 2
e set nova/server/nova.conf/DEFAULT/instance_name_template instance-\\%08x
e set nova/server/nova.conf/DEFAULT/metadata_listen %LOCAL_IP%
e set nova/server/nova.conf/DEFAULT/osapi_compute_listen %LOCAL_IP%
e set nova/server/nova.conf/api/auth_strategy keystone
e set nova/server/nova.conf/api_database/connection %GLOBAL_NOVA_DB_TYPE%://%GLOBAL_NOVA_DB_USER%:%GLOBAL_NOVA_DB_PASS%@%GLOBAL_NOVA_DB_SERVER%/%GLOBAL_NOVA_DB_NAMEAPI%
e set nova/server/nova.conf/cache/backend dogpile.cache.memcached
e set nova/server/nova.conf/cache/enabled True
e set nova/server/nova.conf/cache/memcache_servers %GLOBAL_MEMCACHED_SERVER%
e set nova/server/nova.conf/cinder/os_region_name RegionOne
e set nova/server/nova.conf/database/connection %GLOBAL_NOVA_DB_TYPE%://%GLOBAL_NOVA_DB_USER%:%GLOBAL_NOVA_DB_PASS%@%GLOBAL_NOVA_DB_SERVER%/%GLOBAL_NOVA_DB_NAME%
e set nova/server/nova.conf/filter_scheduler/disk_weight_multiplier 0.0
e set nova/server/nova.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova/server/nova.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set nova/server/nova.conf/keystone_authtoken/auth_type password
e set nova/server/nova.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova/server/nova.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova/server/nova.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova/server/nova.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_NOVA_USER%
e set nova/server/nova.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_NOVA_PASS%
e set nova/server/nova.conf/neutron/auth_strategy keystone
e set nova/server/nova.conf/neutron/auth_type password
e set nova/server/nova.conf/neutron/region_name RegionOne
e set nova/server/nova.conf/neutron/service_metadata_proxy True
e set nova/server/nova.conf/neutron/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova/server/nova.conf/neutron/username %GLOBAL_KEYSTONE_NEUTRON_USER%
e set nova/server/nova.conf/neutron/password %GLOBAL_KEYSTONE_NEUTRON_PASS%
e set nova/server/nova.conf/neutron/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova/server/nova.conf/neutron/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova/server/nova.conf/neutron/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova/server/nova.conf/neutron/metadata_proxy_shared_secret %GLOBAL_NOVA_METADATA_PASS%
e set nova/server/nova.conf/oslo_concurrency/lock_path /var/lib/nova/tmp
e set nova/server/nova.conf/oslo_messaging_rabbit/rabbit_durable_queues True
e set nova/server/nova.conf/oslo_messaging_rabbit/rabbit_ha_queues True
e set nova/server/nova.conf/oslo_messaging_rabbit/rabbit_retry_interval 1
e set nova/server/nova.conf/oslo_messaging_rabbit/rabbit_retry_backoff 2
e set nova/server/nova.conf/placement/os_region_name RegionOne
e set nova/server/nova.conf/placement/auth_type password
e set nova/server/nova.conf/placement/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova/server/nova.conf/placement/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova/server/nova.conf/placement/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova/server/nova.conf/placement/username %GLOBAL_KEYSTONE_PLACEMENT_USER%
e set nova/server/nova.conf/placement/password %GLOBAL_KEYSTONE_PLACEMENT_PASS%
e set nova/server/nova.conf/placement/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova/server/nova.conf/scheduler/discover_hosts_in_cells_interval 300
e set nova/server/nova.conf/vnc/novncproxy_host %LOCAL_IP%
