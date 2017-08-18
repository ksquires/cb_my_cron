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


cron_d 'funds' do
  minute '14'
  hour '7'
  day '*'
  month '*'
  weekday '5'
  command '/home/ksquires/ira/funds.sh > /tmp/funds.out 2>&1'
  user 'ksquires'
end
