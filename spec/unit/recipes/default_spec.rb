#
# Cookbook:: cb_my_cron
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'cb_my_cron::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs package cronie' do
      expect(chef_run).to install_package('cronie')
    end

    it 'enables and starts service[cron]' do
      expect(chef_run).to enable_service('crond')
      expect(chef_run).to start_service('crond')
    end

    it 'creates cron_d[backups]' do
      expect(chef_run).to create_cron_d('backups').with(
        minute: '59',
        hour: '23',
        day: '*',
        month: '*',
        weekday: '*',
        command: '/home/ksquires/bin/backups.sh > /var/log/backups.out 2>&1',
        user: 'root'
      )
    end
  end
end
