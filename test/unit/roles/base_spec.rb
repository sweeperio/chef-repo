describe "base role" do
  before do
    stub_command("which sudo")
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
    expect(chef_run).to include_recipe("base")
  end

  it "sets users attribute" do
    expect(chef_run.node.attr!("users")).to eq(%w(pseudomuto))
  end

  it "sets ruby version and makes it the system version" do
    ruby = chef_run.node.attr!("ruby")
    expect(ruby["versions"].size).to eq(1)
    expect(ruby["system_version"]).to eq(ruby["versions"].first)
  end
end
