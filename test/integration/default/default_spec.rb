describe service('crond') do
  it { should be_enabled }
  it { should be_running }
end

describe package('cronie') do
  it { should be_installed }
end

describe file ('/etc/cron.d/funds') do
  it { should exist }
  its(:content) { should match(/14 7 \* \* 5      ksquires \/home\/ksquires\/ira\/funds.sh > \/tmp\/funds.out 2>&1/) }
end

