ETCD=http://10.255.254.200:2379
alias e="etcdctl -C ${ETCD}"

# Global variables
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

e set GLOBAL/GLANCE/REGISTRY/SERVER os.samana.cloud:9191
e set GLOBAL/GLANCE/DB/TYPE mysql+pymysql
e set GLOBAL/GLANCE/DB/USER glance
e set GLOBAL/GLANCE/DB/PASS Samana81.
e set GLOBAL/GLANCE/DB/SERVER controller.samana.cloud:3306
e set GLOBAL/GLANCE/DB/NAME glance

e set GLOBAL/NEUTRON/SERVER os.samana.cloud:9696

e set GLOBAL/MEMCACHED/SERVER os.samana.cloud:11211

e set GLOBAL/KEYSTONE/SERVER os.samana.cloud:5000
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

# Nova server variables
e set nova_server/nova.conf/DEFAULT/log_dir /var/log/nova
e set nova_server/nova.conf/DEFAULT/lock_path /var/lock/nova
e set nova_server/nova.conf/DEFAULT/state_path /var/lib/nova
e set nova_server/nova.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set nova_server/nova.conf/DEFAULT/my_ip %LOCAL_IP%
e set nova_server/nova.conf/DEFAULT/disk_allocation_ratio 2.0
e set nova_server/nova.conf/DEFAULT/metadata_workers 2
e set nova_server/nova.conf/DEFAULT/osapi_compute_workers 2
e set nova_server/nova.conf/DEFAULT/state_path /var/lib/nova
e set nova_server/nova.conf/DEFAULT/instance_name_template instance-\\%08x
e set nova_server/nova.conf/DEFAULT/metadata_listen %LOCAL_IP%
e set nova_server/nova.conf/DEFAULT/osapi_compute_listen %LOCAL_IP%
e set nova_server/nova.conf/api/auth_strategy keystone
e set nova_server/nova.conf/api_database/connection %GLOBAL_NOVA_DB_TYPE%://%GLOBAL_NOVA_DB_USER%:%GLOBAL_NOVA_DB_PASS%@%GLOBAL_NOVA_DB_SERVER%/%GLOBAL_NOVA_DB_NAMEAPI%
e set nova_server/nova.conf/cache/backend dogpile.cache.memcached
e set nova_server/nova.conf/cache/enabled True
e set nova_server/nova.conf/cache/memcache_servers %GLOBAL_MEMCACHED_SERVER%
e set nova_server/nova.conf/cinder/os_region_name RegionOne
e set nova_server/nova.conf/database/connection %GLOBAL_NOVA_DB_TYPE%://%GLOBAL_NOVA_DB_USER%:%GLOBAL_NOVA_DB_PASS%@%GLOBAL_NOVA_DB_SERVER%/%GLOBAL_NOVA_DB_NAME%
e set nova_server/nova.conf/filter_scheduler/disk_weight_multiplier 0.0
e set nova_server/nova.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova_server/nova.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set nova_server/nova.conf/keystone_authtoken/auth_type password
e set nova_server/nova.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova_server/nova.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova_server/nova.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova_server/nova.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_NOVA_USER%
e set nova_server/nova.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_NOVA_PASS%
e set nova_server/nova.conf/neutron/auth_strategy keystone
e set nova_server/nova.conf/neutron/auth_type password
e set nova_server/nova.conf/neutron/region_name RegionOne
e set nova_server/nova.conf/neutron/service_metadata_proxy True
e set nova_server/nova.conf/neutron/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova_server/nova.conf/neutron/username %GLOBAL_KEYSTONE_NEUTRON_USER%
e set nova_server/nova.conf/neutron/password %GLOBAL_KEYSTONE_NEUTRON_PASS%
e set nova_server/nova.conf/neutron/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova_server/nova.conf/neutron/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova_server/nova.conf/neutron/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova_server/nova.conf/neutron/metadata_proxy_shared_secret %GLOBAL_NOVA_METADATA_PASS%
e set nova_server/nova.conf/oslo_concurrency/lock_path /var/lib/nova/tmp
e set nova_server/nova.conf/oslo_messaging_rabbit/rabbit_durable_queues True
e set nova_server/nova.conf/oslo_messaging_rabbit/rabbit_ha_queues True
e set nova_server/nova.conf/oslo_messaging_rabbit/rabbit_retry_interval 1
e set nova_server/nova.conf/oslo_messaging_rabbit/rabbit_retry_backoff 2
e set nova_server/nova.conf/placement/os_region_name RegionOne
e set nova_server/nova.conf/placement/auth_type password
e set nova_server/nova.conf/placement/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova_server/nova.conf/placement/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova_server/nova.conf/placement/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova_server/nova.conf/placement/username %GLOBAL_KEYSTONE_PLACEMENT_USER%
e set nova_server/nova.conf/placement/password %GLOBAL_KEYSTONE_PLACEMENT_PASS%
e set nova_server/nova.conf/placement/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova_server/nova.conf/scheduler/discover_hosts_in_cells_interval 300
e set nova_server/nova.conf/vnc/novncproxy_host %LOCAL_IP%

# Glance Configurations
e rm --recursive glance-server
e set glance_server/glance-api.conf/DEFAULT/show_image_direct_url True
e set glance_server/glance-api.conf/DEFAULT/show_multiple_locations True
e set glance_server/glance-api.conf/DEFAULT/bind_host %LOCAL_IP%
e set glance_server/glance-api.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set glance_server/glance-api.conf/DEFAULT/registry_host %GLOBAL_GLANCE_REGISTRY_SERVER%
e set glance_server/glance-api.conf/database/connection %GLOBAL_GLANCE_DB_TYPE%://%GLOBAL_GLANCE_DB_USER%:%GLOBAL_GLANCE_DB_PASS%@%GLOBAL_GLANCE_DB_SERVER%/%GLOBAL_GLANCE_DB_NAME%
e set glance_server/glance-api.conf/glance_store/default_store rbd
e set glance_server/glance-api.conf/glance_store/stores file,rbd
e set glance_server/glance-api.conf/glance_store/rbd_store_pool images
e set glance_server/glance-api.conf/glance_store/rbd_store_user images
e set glance_server/glance-api.conf/glance_store/rbd_store_ceph_conf /etc/ceph/ceph.conf
e set glance_server/glance-api.conf/image_format/disk_formats ami,ari,aki,vhd,vhdx,vmdk,raw,qcow2,vdi,iso,ploop.root-tar
e set glance_server/glance-api.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set glance_server/glance-api.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set glance_server/glance-api.conf/keystone_authtoken/auth_type password
e set glance_server/glance-api.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set glance_server/glance-api.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set glance_server/glance-api.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set glance_server/glance-api.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_GLANCE_USER%
e set glance_server/glance-api.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_GLANCE_PASS%
e set glance_server/glance-api.conf/paste_deploy/flavor keystone



