#
# Cookbook:: lldp
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
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
	#action :nothing
	subscribes :restart, 'cookbook_file[/etc/lldpd.conf]', :immediately
	notifies :run, 'execute[show_configuration]', :immediately
end
