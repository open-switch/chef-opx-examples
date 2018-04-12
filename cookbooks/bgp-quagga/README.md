# Sample BGP cookbook for OpenSwitch OPX

The sample BGP cookbook facilitates the configuration of BGP quagga. It requires the Chef setup (workstation-server-client) to be done and working with SSH connection to an OpenSwitch OPX device. 

## Dependencies

The sample BGP recipe inside the cookbook is built on resources included in the core Chef code. The resources are available in Chef 12.17.15.

## Sample BGP configuration

The sample BGP recipe for quagga first installs quagga, copies all configurations to target device, then restarts the quagga service.

Apart from the recipe, these configuration files must be present in the ``files/default/bgp`` folder in the cookbook.
 - daemons
 - quagga.conf
 - vtysh.conf

**Example - files/default/bgp/daemons**

	zebra=yes
	bgpd=yes
	ospfd=no
	ospf6d=no
	ripd=no
	ripngd=no
	isisd=no
	babeld=no

**Example - files/default/bgp/Quagga.conf**

	hostname bgpd
	password zebra
	router bgp 7675
	 bgp router-id 10.0.0.1
	 network 10.0.0.0/8
	 neighbor 10.0.0.4 remote-as 7675
	 neighbor 10.0.0.2 ebgp-multihop

**Example - files/default/bgp/vtysh.conf**

	!
	! Sample configuration file for vtysh.
	!
	service integrated-vtysh-config
	hostname quagga-router
	username root nopassword

**Example recipe - recipes/default.rb**

	apt_package 'quagga' do
        	action :install
        	options '--yes'
	end

	remote_directory "/etc/quagga" do
        	source "bgp"
        	notifies :restart, "service[quagga]"
	end

	service "quagga" do
        	supports :restart => true
        	action [ :enable ]
	end

	execute "check status" do
        	command 'service quagga status'
        	live_stream true
	end

	execute "show configurations" do
        	command "vtysh -c 'show running-config'"
        	live_stream true
	end

**Upload cookbook and execute**

Copy the ``bgp-quagga`` folder to the ``~/chef-repo/cookbooks`` directory.

	knife cookbook upload bgp-quagga
	knife node run_list add opx_node bgp-quagga
	knife ssh 'name:opx_node' 'sudo chef-client' -x admin

## References

- https://docs.chef.io/resource_reference.html
- https://docs.chef.io/resource_apt_package.html
- https://docs.chef.io/resource_remote_directory.html
- https://docs.chef.io/resource_execute.html
- https://docs.chef.io/resource_service.html


Copyright (c) 2018, Dell EMC. All rights reserved.
