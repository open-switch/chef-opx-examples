# Provision CLOS fabric with Chef using Quagga example

The sample cookbook/role facilitates the configuration of routing in OpenSwitch OPX using quagga. It requires the Chef setup (workstation-server-client) to be done and working with an SSH connection to an OpenSwitch OPX device. 

The sample topology is a two-tier CLOS fabric with two spines and two leafs connected as mesh. EBGP is running between the two tiers. All switches in spine have the same AS number, and each leaf switch has a unique AS number. All AS number used are private. Below is the example for configuring BGP and interace using Quagga.

## Routing using Quagga

> **NOTE**: See Routing using Quagga in the OpenSwitch OPX Configuration Guide Release 2.1.0 for more information.

![Alt text](./../_static/quagga-routing.png?raw=true "Title")

## Dependencies

The sample recipe inside the cookbook is built on resources included in the core Chef code. The resources are available in Chef 12.17.15.

## Sample cookbook - CLOS fabric configuration

The sample cookbook installs quagga and copies node specific quagga configurations. Below two configuration files must be present in the ``files/default/quagga`` folder in the cookbook.
 - daemons
 - vtysh.conf

Quagga configurations for all leaf-spines must be present in the files directory of the cookbook - ``leaf1.conf``, ``leaf2.conf``, ``spine1.conf``, and ``spine2.conf``. The node specific configuration file (for example ``leaf1.conf``) will be copied as ``/etc/quagga/Quagga.conf`` in the target node (leaf1).

**Example - files/leaf1.conf**

	hostname leaf1
	interface e101-049-0
	 ip address 10.1.1.1/24
	 no shutdown
	interface e101-051-0
	 ip address 20.1.1.1/24
	 no shutdown
	interface e101-001-0
	 ip address 11.1.1.1/24
	 no shutdown
	router bgp 64501
	 neighbor 10.1.1.2 remote-as 64555
	 neighbor 20.1.1.2 remote-as 64555
	 network 10.1.1.0/24
	 network 20.1.1.0/24
	 network 11.1.1.0/24
	 maximum-paths 16

**Example - recipes/default.rb**

	cookbook_file '/etc/quagga/Quagga.conf' do
	        source "#{node['quagga']['clos_node']}.conf"
        	mode '0755'
	        action :create
        	notifies :restart, "service[quagga]", :immediately
	end

**Upload cookbook**

Copy quagga folder to ~/chef-repo/cookbooks directory.

	knife cookbook upload quagga

## Sample role - CLOS fabric configuration

The sample roles contains four roles - ``leaf1.rb``, ``leaf2.rb``, ``spine1.rb``, and ``spine2.rb``.

**Example - leaf1.rb**

	name "leaf1"
	description "The configurations for leaf1"
	run_list "recipe[quagga]"
	override_attributes "quagga" => { "clos_node" => "leaf1" }

**Upload role**

Copy all four rb files to the ``~/chef-repo/roles`` directory.

	knife role from file roles/leaf1.rb
	knife role from file roles/leaf2.rb
	knife role from file roles/spine1.rb
	knife role from file roles/spine2.rb

**Execute**

> **NOTE**: Add only the specific role (such as leaf1) to the run list of the node. Do not add the cookbook.

	knife node run_list add leaf1 role[leaf1]
	knife ssh 'name:leaf1' 'sudo chef-client' -x admin

## References

- https://docs.chef.io/resource_reference.html
- https://docs.chef.io/roles.html

Copyright (c) 2018, Dell EMC. All rights reserved.
