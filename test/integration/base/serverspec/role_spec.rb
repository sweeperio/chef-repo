require "spec_helper"

describe "base[role]" do
  context "users" do
    describe user("pseudomuto") do
      it { should exist }
      it { should belong_to_group("pseudomuto") }
      it { should belong_to_group("sudoers") }
    end

    describe file("/home/pseudomuto/.ssh") do
      it { should exist }
      it { should be_directory }
    end

    describe file("/home/pseudomuto/.ssh/id_rsa") do
      it { should_not exist }
    end
  end

  context "chef-client" do
    describe service("chef-client") do
      it { should be_running }
    end
  end

  context "ruby" do
    describe command("ruby -v") do
      its(:exit_status) { should eq(0) }
      its(:stdout) { should contain("ruby 2.2.3") }
    end
  end
end
