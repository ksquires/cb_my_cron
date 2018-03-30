#
# Cookbook:: cb_my_cron
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

include_recipe 'cron::default'

package 'cronie' do
  action :install
end

service 'crond' do
  action [:enable, :start]
end

if node.role?('primary_box')
  file '/etc/cron.d/funds' do
    action :delete
    only_if { ::File.exist?('/etc/cron.d/funds') }
  end
end

cron_d 'backups' do
  minute '59'
  hour '23'
  day '*'
  month '*'
  weekday '*'
  command '/home/ksquires/bin/backups.sh > /var/log/backups.out 2>&1'
  user 'root'
end
