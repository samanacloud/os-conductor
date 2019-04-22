#!/bin/bash

ETCD=http://10.255.254.200:2379

e() {
    etcdctl -C ${ETCD} "$@"
}

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
e rm --recursive glance_server/

e rm --recursive glance_server/glance-api.conf
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

e rm --recursive glance_server/glance-registry.conf
e set glance_server/glance-registry.conf/DEFAULT/bind_host %LOCAL_IP%
e set glance_server/glance-registry.conf/database/connection %GLOBAL_GLANCE_DB_TYPE%://%GLOBAL_GLANCE_DB_USER%:%GLOBAL_GLANCE_DB_PASS%@%GLOBAL_GLANCE_DB_SERVER%/%GLOBAL_GLANCE_DB_NAME%
e set glance_server/glance-registry.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set glance_server/glance-registry.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set glance_server/glance-registry.conf/keystone_authtoken/auth_type password
e set glance_server/glance-registry.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set glance_server/glance-registry.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set glance_server/glance-registry.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set glance_server/glance-registry.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_GLANCE_USER%
e set glance_server/glance-registry.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_GLANCE_PASS%
e set glance_server/glance-registry.conf/paste_deploy/flavor keystone


# Cinder Configurations
e rm --recursive cinder_server

e set cinder_server/cinder.conf/DEFAULT/rootwrap_config /etc/cinder/rootwrap.conf
e set cinder_server/cinder.conf/DEFAULT/api_paste_confg /etc/cinder/api-paste.ini
e set cinder_server/cinder.conf/DEFAULT/iscsi_helper tgtadm
e set cinder_server/cinder.conf/DEFAULT/volume_name_template volume-%s
e set cinder_server/cinder.conf/DEFAULT/volume_group cinder-volumes
e set cinder_server/cinder.conf/DEFAULT/auth_strategy keystone
e set cinder_server/cinder.conf/DEFAULT/state_path /var/lib/cinder
e set cinder_server/cinder.conf/DEFAULT/lock_path /var/lock/cinder
e set cinder_server/cinder.conf/DEFAULT/volumes_dir /var/lib/cinder/volumes
e set cinder_server/cinder.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set cinder_server/cinder.conf/DEFAULT/my_ip %LOCAL_IP%
e set cinder_server/cinder.conf/DEFAULT/glance_api_servers %GLOBAL_GLANCE_API_SERVER%
e set cinder_server/cinder.conf/DEFAULT/storage_availability_zone FL1
e set cinder_server/cinder.conf/DEFAULT/default_availability_zone FL1
e set cinder_server/cinder.conf/DEFAULT/allow_availability_zone_fallback True
e set cinder_server/cinder.conf/DEFAULT/cinder_internal_tenant_user_id %GLOBAL_CINDER_INTERNAL_TENANT_USER_ID%
e set cinder_server/cinder.conf/DEFAULT/cinder_internal_tenant_project_id %GLOBAL_CINDER_INTERNAL_TENANT_PROJECT_ID%
e set cinder_server/cinder.conf/DEFAULT/image_volume_cache_enabled True
e set cinder_server/cinder.conf/database/connection %GLOBAL_CINDER_DB_TYPE%://%GLOBAL_CINDER_DB_USER%:%GLOBAL_CINDER_DB_PASS%@%GLOBAL_CINDER_DB_SERVER%/%GLOBAL_CINDER_DB_NAME%
e set cinder_server/cinder.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set cinder_server/cinder.conf/keystone_authtoken/auth_uri http://%GLOBAL_KEYSTONE_SERVER%/v3
e set cinder_server/cinder.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set cinder_server/cinder.conf/keystone_authtoken/auth_type password
e set cinder_server/cinder.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set cinder_server/cinder.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set cinder_server/cinder.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set cinder_server/cinder.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_CINDER_USER%
e set cinder_server/cinder.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_CINDER_PASS%
e set cinder_server/cinder.conf/oslo_concurrency/lock_path /var/lib/cinder/tmp

# Neutron Configurations
e rm --recursive neutron_server

e set neutron_server/neutron.conf/DEFAULT/l3_ha True
e set neutron_server/neutron.conf/DEFAULT/service_plugins neutron.services.l3_router.l3_router_plugin.L3RouterPlugin
e set neutron_server/neutron.conf/DEFAULT/rpc_state_report_workers 0
e set neutron_server/neutron.conf/DEFAULT/api_workers 2
e set neutron_server/neutron.conf/DEFAULT/notify_nova_on_port_data_changes True
e set neutron_server/neutron.conf/DEFAULT/notify_nova_on_port_status_changes True
e set neutron_server/neutron.conf/DEFAULT/auth_strategy keystone
e set neutron_server/neutron.conf/DEFAULT/allow_overlapping_ips True
e set neutron_server/neutron.conf/DEFAULT/core_plugin ml2
e set neutron_server/neutron.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set neutron_server/neutron.conf/DEFAULT/bind_host %LOCAL_IP%
e set neutron_server/neutron.conf/DEFAULT/use_syslog False
e set neutron_server/neutron.conf/DEFAULT/state_path /var/lib/neutron
e set neutron_server/neutron.conf/DEFAULT/dhcp_agents_per_network 2
e set neutron_server/neutron.conf/agent/root_helper_daemon "\"sudo /usr/bin/neutron-rootwrap-daemon /etc/neutron/rootwrap.conf\""
e set neutron_server/neutron.conf/agent/root_helper "\"sudo /usr/bin/neutron-rootwrap /etc/neutron/rootwrap.conf\""
e set neutron_server/neutron.conf/database/connection %GLOBAL_NEUTRON_DB_TYPE%://%GLOBAL_NEUTRON_DB_USER%:%GLOBAL_NEUTRON_DB_PASS%@%GLOBAL_NEUTRON_DB_SERVER%/%GLOBAL_NEUTRON_DB_NAME%
e set neutron_server/neutron.conf/keystone_authtoken/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set neutron_server/neutron.conf/keystone_authtoken/www_authenticate_uri http://%GLOBAL_KEYSTONE_PUBLICSERVER%/
e set neutron_server/neutron.conf/keystone_authtoken/memcached_servers %GLOBAL_MEMCACHED_SERVER%
e set neutron_server/neutron.conf/keystone_authtoken/auth_type password
e set neutron_server/neutron.conf/keystone_authtoken/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set neutron_server/neutron.conf/keystone_authtoken/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set neutron_server/neutron.conf/keystone_authtoken/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set neutron_server/neutron.conf/keystone_authtoken/username %GLOBAL_KEYSTONE_NEUTRON_USER%
e set neutron_server/neutron.conf/keystone_authtoken/password %GLOBAL_KEYSTONE_NEUTRON_PASS%
e set neutron_server/neutron.conf/nova/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set neutron_server/neutron.conf/nova/auth_type password
e set neutron_server/neutron.conf/nova/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set neutron_server/neutron.conf/nova/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set neutron_server/neutron.conf/nova/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set neutron_server/neutron.conf/nova/region_name RegionOne
e set neutron_server/neutron.conf/nova/username %GLOBAL_KEYSTONE_NOVA_USER%
e set neutron_server/neutron.conf/nova/password %GLOBAL_KEYSTONE_NOVA_PASS%
e set neutron_server/neutron.conf/oslo_policy/policy_file /etc/neutron/policy.json


e set neutron_server/plugins/ml2/ml2_conf.ini/ml2/tenant_network_types vxlan,vlan
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2/extension_drivers port_security
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2/type_drivers vxlan,flat,vlan
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2/mechanism_drivers openvswitch
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2_type_flat/flat_networks public,public-dedicated
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2_type_geneve/vni_ranges 1:1000
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2_type_gre/tunnel_id_ranges 1:1000
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2_type_vlan/network_vlan_ranges provider:200:299
e set neutron_server/plugins/ml2/ml2_conf.ini/ml2_type_vxlan/vni_ranges 1:1000
e set neutron_server/plugins/ml2/ml2_conf.ini/securitygroup/firewall_driver iptables_hybrid
e set neutron_server/plugins/ml2/ml2_conf.ini/agent/tunnel_types vxlan
e set neutron_server/plugins/ml2/ml2_conf.ini/agent/tunnel_types/root_helper_daemon "\"sudo /usr/bin/neutron-rootwrap-daemon /etc/neutron/rootwrap.conf\""
e set neutron_server/plugins/ml2/ml2_conf.ini/agent/tunnel_types/root_helper "\"sudo /usr/bin/neutron-rootwrap /etc/neutron/rootwrap.conf\""
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/datapath_type system
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/bridge_mappings public:br-ex,public-dedicated:br-dedicated,provider:br-provider
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/tunnel_bridge br-tun
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/local_ip %LOCAL_IP%


