# Sample interface cookbook for OpenSwitch OPX

The sample interface cookbook facilitates the configuration of interface (IPv4) using Chef the resource ``ifconfig``. It requires the Chef setup (workstation-server-client) to be done and working with an SSH connection to an OpenSwitch OPX device. 

## Dependencies

The sample interface recipe inside the cookbook is built on resources included in the core Chef code. The resources are available in chef 12.17.15.

## Sample interface configuration

The sample interface recipe uses the Chef built-in resource ``ifconfig`` to configure an interface.

**Example recipe - recipes/default.rb**

	execute 'show_intf' do
        	command 'ifconfig e101-001-0'
        	live_stream true
	end

	ifconfig 'add_intf' do
        	target '7.7.7.7'
        	mtu '777'
        	bootproto 'dhcp'
        	device 'e101-001-0'
        	action [:add]
        	notifies :run, 'execute[show_intf]', :immediately
	end

	ifconfig 'disable_intf' do
        	device 'e101-001-0'
        	action :disable
        	notifies :run, 'execute[show_intf]', :immediately
	end

	ifconfig 'enable_intf' do
        	device 'e101-001-0'
        	target '7.7.7.7'
        	action :enable
        	notifies :run, 'execute[show_intf]', :immediately
	end

	ifconfig 'delete_intf' do
        	device 'e101-001-0'
        	action :delete
        	notifies :run, 'execute[show_intf]', :immediately
	end

**Upload cookbook and execute**

Copy the ``interface`` folder to the ``~/chef-repo/cookbooks`` directory.

	knife cookbook upload interface
	knife node run_list add opx_node interface
	knife ssh 'name:opx_node' 'sudo chef-client' -x admin

## References

- https://docs.chef.io/resource_reference.html
- https://docs.chef.io/resource_ifconfig.html
- https://docs.chef.io/resource_execute.html

(c) 2018 Dell Inc. or its subsidiaries. All Rights Reserved.
