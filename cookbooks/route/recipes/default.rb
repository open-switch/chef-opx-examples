#
# Cookbook:: route
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
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
