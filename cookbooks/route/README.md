# Sample route cookbook for OpenSwitch OPX

The sample route cookbook facilitates the configuration of static route (IPv4) using Chef resource route. It requires the Chef setup (workstation-server-client) to be done and working with an SSH connection to an OpenSwitch OPX device. 

## Dependencies

The sample route recipe inside the cookbook is built on resources included in the core Chef code. The resources are available in chef 12.17.15.

## Sample route configuration

The sample route recipe uses the Chef built-in resource route to configure static route entries into the routing table.

**Example recipe - recipes/default.rb**

	execute 'show_route' do
        	command 'ip route show'
        	live_stream true
	end

	route 'add_route' do
        	target '10.18.0.0/24'
        	gateway '10.16.138.12'
        	device 'eth0'
        	ignore_failure true
        	notifies :run, 'execute[show_route]', :immediately
	end

	route '10.18.0.0/24' do
        	gateway '10.16.138.12'
        	action :delete
        	notifies :run, 'execute[show_route]', :immediately
	end

**Upload cookbook and execute**

Copy the ``route`` folder to the ``~/chef-repo/cookbooks`` directory.

	knife cookbook upload route
	knife node run_list add opx_node route
	knife ssh 'name:opx_node' 'sudo chef-client' -x admin

## References

- https://docs.chef.io/resource_reference.html
- https://docs.chef.io/resource_route.html
- https://docs.chef.io/resource_execute.html


Copyright (c) 2018, Dell EMC. All rights reserved.
