require "spec_helper"

describe "base[role] when in development environment" do
  context "ruby" do
    describe command("ruby -v") do
      its(:exit_status) { should eq(0) }
      its(:stdout) { should contain("ruby 2.3.0") }
    end

    %w(2.1.8 2.2.3 2.3.0).each do |version|
      describe file("/opt/rubies/#{version}/bin/ruby") do
        it { should exist }
        it { should be_file }
      end
    end
  end
end
