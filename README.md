
# Sample Chef cookbooks for OpenSwitch OPX

Chef is a powerful automation platform that transforms infrastructure into code. Whether you are operating in the cloud, on-premises or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network - no matter its size.

	https://docs.chef.io/
	https://docs.chef.io/chef_overview.html

Chef has three main components:

 - The Chef DK workstation is the location where users interact with Chef. On the workstation, users author and test cookbooks using tools such as Test Kitchen and interact with the Chef server using the knife and Chef command line tools.

 - Chef client nodes are the machines (such as OPX devices) that are managed by Chef. The Chef client is installed on each node and is used to configure the node to its desired state.

 - The Chef server acts as a hub for configuration data. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describe each registered node that is being managed by Chef. Nodes use the Chef client to ask the Chef server for configuration details such as recipes, templates, and file distributions.

This directory contains sample Chef cookbooks that facilitate the configuration of various features like LLDP, interface, route, BGP (quagga) and port mirroring.

## Dependencies

The sample recipe inside the cookbooks are built on resources included in the core Chef code. The resources are available in Chef 12.17.15. It requires the Chef setup (workstation-server-client) to be done and working with an SSH connection to an OpenSwitch OPX device (client).
 
## Reference - Chef setup and execution

**Chef setup**

Refer to these links for the Chef (server-client-workstation) setup:

	https://docs.chef.io/install_server.html
	https://docs.chef.io/workstation.html
	https://docs.chef.io/chef_client_overview.html
	https://docs.chef.io/knife.html

**Cookbooks/roles**

Cookbooks are written, tested and maintained in Chef workstations. The cookbooks are uploaded to the Chef server from the workstation. 

	https://docs.chef.io/cookbooks.html
	https://docs.chef.io/resource_reference.html
	https://docs.chef.io/roles.html
    
> **NOTE**: Various sample cookbooks are available in https://supermarket.chef.io/cookbooks.

**Example - upload cookbook and execute**

Copy the sample cookbooks to ~/chef-repo/cookbooks directory in workstation.

> **NOTE**: ``my_node`` is the Chef client created for a OPX device.

Copy the sample cookbooks in cookbooks directory to ``~/chef-repo/cookbooks`` in the workstation. The ``clos-fabric`` folder alone contains both the cookbook and the role to configure a leaf-spine topology.

**NOTE**: ``opx_node`` is the Chef client created for an OpenSwitch OPX device.

	Upload the cookbook (ex: lldp) from local repository to chef server.
		knife cookbook upload lldp
	Include the cookbook/role into the run_list of the managed node.
		knife node run_list add opx_node lldp (and/or)
		knife node run_list add opx_node role[leaf1]
	Execute the run_list of the node (chef client)
		knife ssh 'name:opx_node' 'sudo chef-client'

(c) 2018 Dell Inc. or its subsidiaries. All Rights Reserved.
