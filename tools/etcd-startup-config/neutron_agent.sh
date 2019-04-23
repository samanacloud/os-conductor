#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

e set neutron_agent/neutron.conf/DEFAULT/service_plugins neutron.services.l3_router.l3_router_plugin.L3RouterPlugin
e set neutron_agent/neutron.conf/DEFAULT/rpc_state_report_workers 0
e set neutron_agent/neutron.conf/DEFAULT/api_workers 2
e set neutron_agent/neutron.conf/DEFAULT/notify_nova_on_port_data_changes True
e set neutron_agent/neutron.conf/DEFAULT/notify_nova_on_port_status_changes True
e set neutron_agent/neutron.conf/DEFAULT/auth_strategy keystone
e set neutron_agent/neutron.conf/DEFAULT/allow_overlapping_ips True
e set neutron_agent/neutron.conf/DEFAULT/core_plugin ml2
e set neutron_agent/neutron.conf/DEFAULT/transport_url %GLOBAL_TRANSPORT_TYPE%://%GLOBAL_TRANSPORT_USER%:%GLOBAL_TRANSPORT_PASS%@%GLOBAL_TRANSPORT_SERVER%:%GLOBAL_TRANSPORT_PORT%
e set neutron_agent/neutron.conf/DEFAULT/bind_host 0.0.0.0
e set neutron_agent/neutron.conf/DEFAULT/use_syslog False
e set neutron_agent/neutron.conf/DEFAULT/state_path /var/lib/neutron
e set neutron_agent/neutron.conf/DEFAULT/global_physnet_mtu 9000
e set neutron_agent/neutron.conf/agent/root_helper_daemon "\"sudo /usr/bin/neutron-rootwrap-daemon /etc/neutron/rootwrap.conf\""
e set neutron_agent/neutron.conf/agent/root_helper "\"sudo /usr/bin/neutron-rootwrap /etc/neutron/rootwrap.conf\""
e set neutron_agent/neutron.conf/oslo_policy/policy_file /etc/neutron/policy.json

e set neutron_agent/l3_agent.ini/DEFAULT/interface_driver openvswitch
e set neutron_agent/l3_agent.ini/DEFAULT/external_network_bridge ""
e set neutron_agent/l3_agent.ini/DEFAULT/ovs_use_veth False
e set neutron_agent/l3_agent.ini/DEFAULT/use_namespaces True

e set neutron_agent/metadata_agent.ini/DEFAULT/auth_url http://%GLOBAL_KEYSTONE_SERVER%/v2.0
e set neutron_agent/metadata_agent.ini/DEFAULT/auth_region RegionOne
e set neutron_agent/metadata_agent.ini/DEFAULT/nova_metadata_host %GLOBAL_NOVA_METADATA_HOST%
e set neutron_agent/metadata_agent.ini/DEFAULT/metadata_proxy_shared_secret %GLOBAL_NOVA_METADATA_PASS%

e set neutron_agent/dhcp_agent.ini/DEFAULT/interface_driver openvswitch
e set neutron_agent/dhcp_agent.ini/DEFAULT/ovs_use_veth False
e set neutron_agent/dhcp_agent.ini/DEFAULT/use_namespaces True
e set neutron_agent/dhcp_agent.ini/DEFAULT/dnsmasq_local_resolv True
e set neutron_agent/dhcp_agent.ini/DEFAULT/enable_isolated_metadata True


e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2/type_drivers vxlan,flat,vlan
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2/tenant_network_types vxlan,vlan
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2/extension_drivers port_security
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2/mechanism_drivers openvswitch
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2/path_mtu 9000
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2_type_flat/flat_networks public,public-dedicated
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2_type_geneve/vni_ranges 1:1000
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2_type_gre/tunnel_id_ranges 1:1000
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2_type_vlan/network_vlan_ranges provider:200:299
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ml2_type_vxlan/vni_ranges 1:1000
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/securitygroup/firewall_driver iptables_hybrid
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/agent/tunnel_types vxlan
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ovs/integration_bridge br-int
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ovs/datapath_type system
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ovs/bridge_mappings public:br-ex,public-dedicated:br-dedicated,provider:br-provider
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ovs/tunnel_bridge br-tun
e set neutron_agent/plugins/ml2/openvswitch_agent.ini/ovs/local_ip %LOCAL_IP%
