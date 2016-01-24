describe "base role" do
  before do
    stub_data_bag_item("users", "pseudomuto").and_return(
      id: "pseudomuto",
      comment: "David Muto",
      groups: %w(sudoers)
    )
  end

  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.converge("role[base]")
  end

  it "includes the base cookbook" do
    expect(chef_run).to include_recipe("swpr_base")
  end

  it "sets users attribute" do
    expect(chef_run.node.attr!("users")).to eq(%w(pseudomuto))
  end

  it "sets ruby version and makes it the system version" do
    ruby = chef_run.node.attr!("swpr_ruby")
    expect(ruby["versions"].size).to eq(1)
    expect(ruby["system_version"]).to eq(ruby["versions"].first)
  end

  context "when running in the development environment", env: :development do
    cached(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge("role[base]")
    end

    it "includes multiple versions of ruby" do
      ruby = chef_run.node.attr!("swpr_ruby")
      expect(ruby["versions"].size).to eq(3)
      expect(ruby["system_version"]).to eq(ruby["versions"].last)
    end
  end
end
