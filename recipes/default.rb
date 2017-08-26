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

# somehow need to limit to run on role['primary_server']
cron_d 'funds' do
  minute '14'
  hour '7'
  day '*'
  month '*'
  weekday '5'
  command '/home/ksquires/ira/funds.sh > /tmp/funds.out 2>&1'
  user 'ksquires'
end

cron_d 'backups' do
  minute '59'
  hour '23'
  day '*'
  month '*'
  weekday '*'
  command '/home/ksquires/bin/backups.sh > /var/log/backups.out 2>&1'
  user 'ksquires'
end
