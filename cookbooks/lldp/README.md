# Sample LLDP cookbook for OpenSwitch OPX

The sample LLDP cookbook facilitates the configuration of link layer discovery protocol (LLDP) using ``lldpcli``. It requires the Chef setup (workstation-server-client) to be done and working with an SSH connection to an OpenSwitch OPX device. 

## Dependencies

The sample LLDP recipe inside the cookbook is built on resources included in the core Chef code. The resources are available in chef 12.17.15.

## Sample LLDP configuration

The sample LLDP recipe uses the file push mechanism where an ``lldpd.conf`` file containing all ``lldpcli`` commands is first pushed to ``/etc`` in the target device, and the ``lldpd`` service is restarted for the change to take effect. 

The cookbook contains two files - ``files/lldpd.conf`` and ``recipes/default.rb``.

**Example conf file - files/lldpd.conf**

	configure lldp tx-interval 33
	configure lldp tx-hold 3
	configure med fast-start enable
	configure med fast-start tx-interval 3

**Example recipe - recipes/default.rb**

	execute 'show_configuration' do
        	command 'sudo lldpcli show configuration'
        	live_stream true
	end

	cookbook_file '/etc/lldpd.conf' do
        	source 'lldpd.conf'
        	mode '0755'
        	action :create
	end

	service 'lldpd' do
        	subscribes :restart, 'cookbook_file[/etc/lldpd.conf]', :immediately
        	notifies :run, 'execute[show_configuration]', :immediately
	end

**Upload cookbook and execute**

Copy the ``lldp`` folder to the ``~/chef-repo/cookbooks`` directory.

	knife cookbook upload lldp
	knife node run_list add opx_node lldp
	knife ssh 'name:opx_node' 'sudo chef-client'

## References

- https://docs.chef.io/resource_reference.html
- https://docs.chef.io/resource_execute.html
- https://docs.chef.io/resource_cookbook_file.html
- https://docs.chef.io/resource_service.html


Copyright (c) 2018, Dell EMC. All rights reserved.
