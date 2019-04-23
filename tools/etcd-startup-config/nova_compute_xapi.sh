#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

e rm --recursive nova/compute_xapi

HOST=$1
if [ "${HOST}" == ""  ]; then
    echo "Usage: $0 <host>"
    exit(1)
fi

e set nova/compute_xapi/nova.conf/DEFAULT/log_dir /var/log/nova
e set nova/compute_xapi/nova.conf/DEFAULT/lock_path /var/lock/nova
e set nova/compute_xapi/nova.conf/DEFAULT/state_path /var/lib/nova
e set nova/compute_xapi/nova.conf/DEFAULT/instances_path /var/lib/nova/instances/
e set nova/compute_xapi/nova.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set nova/compute_xapi/nova.conf/DEFAULT/my_ip %LOCAL_IP%
e set nova/compute_xapi/nova.conf/DEFAULT/disk_allocation_ratio 2.0
e set nova/compute_xapi/nova.conf/DEFAULT/host ${HOST}
e set nova/compute_xapi/nova.conf/DEFAULT/compute_driver xenapi.XenAPIDriver
e set nova/compute_xapi/nova.conf/api/auth_strategy keystone
e set nova/compute_xapi/nova.conf/cells/enable False
e set nova/compute_xapi/nova.conf/cinder/os_region_name RegionOne
e set nova/compute_xapi/nova.conf/glance/api_servers %GLOBAL_GLANCE_API_SERVER%
e set nova/compute_xapi/nova.conf/neutron/auth_strategy keystone
e set nova/compute_xapi/nova.conf/neutron/auth_type password
e set nova/compute_xapi/nova.conf/neutron/region_name RegionOne
e set nova/compute_xapi/nova.conf/neutron/service_metadata_proxy True
e set nova/compute_xapi/nova.conf/neutron/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova/compute_xapi/nova.conf/neutron/username %GLOBAL_KEYSTONE_NEUTRON_USER%
e set nova/compute_xapi/nova.conf/neutron/password %GLOBAL_KEYSTONE_NEUTRON_PASS%
e set nova/compute_xapi/nova.conf/neutron/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova/compute_xapi/nova.conf/neutron/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova/compute_xapi/nova.conf/neutron/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova/compute_xapi/nova.conf/oslo_concurrency/lock_path /var/lib/nova/tmp
e set nova/compute_xapi/nova.conf/placement/os_region_name RegionOne
e set nova/compute_xapi/nova.conf/placement/auth_type password
e set nova/compute_xapi/nova.conf/placement/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v3
e set nova/compute_xapi/nova.conf/placement/project_name %GLOBAL_KEYSTONE_PROJECT_NAME%
e set nova/compute_xapi/nova.conf/placement/project_domain_name %GLOBAL_KEYSTONE_PROJECT_DOMAIN%
e set nova/compute_xapi/nova.conf/placement/username %GLOBAL_KEYSTONE_PLACEMENT_USER%
e set nova/compute_xapi/nova.conf/placement/password %GLOBAL_KEYSTONE_PLACEMENT_PASS%
e set nova/compute_xapi/nova.conf/placement/user_domain_name %GLOBAL_KEYSTONE_USER_DOMAIN%
e set nova/compute_xapi/nova.conf/scheduler/discover_hosts_in_cells_interval 300
e set nova/compute_xapi/nova.conf/vnc/server_proxyclient_address %LOCAL_IP%
e set nova/compute_xapi/nova.conf/vnc/server_listen 0.0.0.0
e set nova/compute_xapi/nova.conf/vnc/novncproxy_base_url %GLOBAL_NOVNCPROXY_BASE_URL%
e set nova/compute_xapi/nova.conf/vnc/enabled true
e set nova/compute_xapi/nova.conf/xenserver/ovs_integration_bridge br-int
e set nova/compute_xapi/nova.conf/xenserver/vif_driver nova.virt.xenapi.vif.XenAPIOpenVswitchDriver
e set nova/compute_xapi/nova.conf/xenserver/connection_password %GLOBAL_XEN_${HOST}_PASS%
e set nova/compute_xapi/nova.conf/xenserver/connection_username %GLOBAL_XEN_${HOST}_USER%
e set nova/compute_xapi/nova.conf/xenserver/connection_url http://%GLOBAL_XEN_${HOST}_HOST%
