#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

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
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/datapath_type system
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/bridge_mappings public:br-ex,public-dedicated:br-dedicated,provider:br-provider
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/tunnel_bridge br-tun
e set neutron_server/plugins/ml2/ml2_conf.ini/ovs/local_ip %LOCAL_IP%
