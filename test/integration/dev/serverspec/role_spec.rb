require "spec_helper"

describe "dev[role]" do
  APPLICATIONS = %w(
    cargo rustc rustdoc
    heroku
    hub
    go godoc gofmt gb godep
    luajit
    node npm coffee grunt
    redis-cli redis-server
    tmux
    vim
  ).freeze

  SERVICES = %w(
    memcached
    postgresql
    redis6379
  ).freeze

  APPLICATIONS.each do |app|
    describe command("source /etc/profile && which #{app}") do
      let(:shell) { "/bin/bash" }
      its(:exit_status) { should eq(0) }
    end
  end

  SERVICES.each do |service|
    describe service(service) do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
