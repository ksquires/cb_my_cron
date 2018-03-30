describe service('crond') do
  it { should be_enabled }
  it { should be_running }
end

describe package('cronie') do
  it { should be_installed }
end

describe file '/etc/cron.d/backups' do
  it { should exist }
  its(:content) { should match %r{14 7 * * 5      ksquires /home/ksquires/bin/backups.sh > /var/log/backups.out  2>&1/} }
end
