#
# Cookbook:: quagga
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

apt_package 'quagga' do
	action :install
	options '--yes'
end

remote_directory "/etc/quagga" do
	source "quagga"
end

cookbook_file '/etc/quagga/Quagga.conf' do
	source "#{node['quagga']['clos_node']}.conf"
	mode '0755'
	action :create
	notifies :restart, "service[quagga]", :immediately
end

service "quagga" do
	supports :restart => true
	action :enable
end

execute "check status" do
	command 'service quagga status'
	live_stream true
end

execute "show configurations" do
	command "vtysh -c 'show running-config'"
	live_stream true
end
