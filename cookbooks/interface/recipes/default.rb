#
# Cookbook:: interface
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
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
