#
# Cookbook:: port-mirroring
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
execute 'delete_mirror' do
	command "cps_config_mirror.py delete 10"
	live_stream true
end

execute 'create_mirror' do
	command "cps_config_mirror.py create span e101-003-0 e101-004-0 both"
	live_stream true
end
