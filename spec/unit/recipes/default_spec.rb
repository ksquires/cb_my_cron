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

    it 'creates cron_d[funds]' do
      expect(chef_run).to create_cron_d('funds').with(
        minute: '14',
	hour: '7',
	day: '*',
	month: '*',
	weekday: '5',
	command: '/home/ksquires/ira/funds.sh > /tmp/funds.out 2>&1',
	user: 'ksquires'
     )
    end
  end
end
