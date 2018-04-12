# Sample port mirroring cookbook for OpenSwitch OPX

The sample cookbook facilitates the configuration of port-mirroring. It requires the Chef setup (workstation-server-client) to be done and working with an SSH connection to an OpenSwitch OPX device. 

## Dependencies

The sample port mirroring recipe inside the cookbook is built on resources included in the core Chef code. The resources are available in chef 12.17.15.

## Sample port mirroring configuration

The sample port mirroring recipe uses the Chef built-in resource ``execute`` to execute the OpenSwitch OPX provided Python script to configure the port mirroring using CPS.

**Example recipe - recipes/default.rb**

	execute 'delete_mirror' do
        	command "cps_config_mirror.py delete 10"
        	live_stream true
	end

	execute 'create_mirror' do
        	command "cps_config_mirror.py create span e101-003-0 e101-004-0 both"
        	live_stream true
	end

**Upload cookbook and execute**

Copy the ``port-mirroring`` folder to the ``~/chef-repo/cookbooks`` directory.

**NOTE**: For port mirroring CPS commands to work, the ``opx_node`` node must have been configured with root login.

	knife cookbook upload port-mirroring
	knife node run_list add opx_node port-mirroring
	knife ssh 'name:opx_node' 'sudo chef-client'

## References

- https://docs.chef.io/resource_reference.html
- https://docs.chef.io/resource_execute.html


Copyright (c) 2018, Dell EMC. All rights reserved.
