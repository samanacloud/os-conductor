#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

e rm --recursive nova_agent

e set nova_agent/nova.conf/DEFAULT/log_dir /var/log/nova
e set nova_agent/nova.conf/DEFAULT/lock_path /var/lock/nova
e set nova_agent/nova.conf/DEFAULT/state_path /var/lib/nova
e set nova_agent/nova.conf/DEFAULT/instances_path /var/lib/nova/instances/
e set nova_agent/nova.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set nova_agent/nova.conf/DEFAULT/my_ip %LOCAL_IP%
e set nova_agent/nova.conf/DEFAULT/disk_allocation_ratio 2.0
e set nova_agent/nova.conf/DEFAULT/force_raw_images True
e set nova_agent/nova.conf/DEFAULT/disk_cachemodes writeback
e set nova_agent/nova.conf/DEFAULT/compute_driver libvirt.LibvirtDriver
e set nova_agent/nova.conf/api/auth_strategy keystone
e set nova_agent/nova.conf/cells/enable False
e set nova_agent/nova.conf/cinder/os_region_name RegionOne
e set nova_agent/nova.conf/glance/api_servers %GLOBAL_GLANCE_API_SERVER%
e set nova_agent/nova.conf/libvirt/images_type rbd
e set nova_agent/nova.conf/libvirt/images_rbd_pool %GLOBAL_RBD_VMPOOL%
e set nova_agent/nova.conf/libvirt/images_rbd_ceph_conf /etc/ceph/ceph.conf
e set nova_agent/nova.conf/libvirt/rbd_user %GLOBAL_RBD_USER%
e set nova_agent/nova.conf/libvirt/rbd_secret_uuid %GLOBAL_RBD_SECRET_UUID%
e set nova_agent/nova.conf/libvirt/virt_type kvm
e set nova_agent/nova.conf/neutron/auth_strategy keystone
e set nova_agent/nova.conf/neutron/auth_type password
e set nova_agent/nova.conf/neutron/region_name RegionOne
e set nova_agent/nova.conf/neutron/service_metadata_proxy True
e set nova_agent/nova.conf/neutron/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova_agent/nova.conf/neutron/username %GLOBAL_KEYSTONE_NEUTRON_USER%
e set nova_agent/nova.conf/neutron/password %GLOBAL_KEYSTONE_NEUTRON_PASS%
e set nova_agent/nova.conf/neutron/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova_agent/nova.conf/neutron/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova_agent/nova.conf/neutron/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova_agent/nova.conf/oslo_concurrency/lock_path /var/lib/nova/tmp
e set nova_agent/nova.conf/placement/os_region_name RegionOne
e set nova_agent/nova.conf/placement/auth_type password
e set nova_agent/nova.conf/placement/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova_agent/nova.conf/placement/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova_agent/nova.conf/placement/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova_agent/nova.conf/placement/username %GLOBAL_KEYSTONE_PLACEMENT_USER%
e set nova_agent/nova.conf/placement/password %GLOBAL_KEYSTONE_PLACEMENT_PASS%
e set nova_agent/nova.conf/placement/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova_agent/nova.conf/scheduler/discover_hosts_in_cells_interval 300
e set nova_agent/nova.conf/vnc/server_proxyclient_address %LOCAL_IP%
e set nova_agent/nova.conf/vnc/server_listen 0.0.0.0
e set nova_agent/nova.conf/vnc/novncproxy_base_url %GLOBAL_NOVNCPROXY_BASE_URL%
e set nova_agent/nova.conf/vnc/enabled true
