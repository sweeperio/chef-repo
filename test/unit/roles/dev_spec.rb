describe "dev role" do
  before do
    stub_command(%r{ls /.*/recovery.conf}).and_return(false)

    stub_data_bag_item("users", "pseudomuto").and_return(
      id: "pseudomuto",
      comment: "David Muto",
      groups: %w(sudoers)
    )
  end

  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.converge("role[dev]")
  end

  it "includes the base role" do
    expect(chef_run).to include_recipe("swpr_base")
  end

  it "includes the dev recipe" do
    expect(chef_run).to include_recipe("swpr_dev")
  end

  %w(golang nodejs postgresql rustlang).each do |recipe|
    it "includes the swpr_dev::#{recipe} recipe" do
      expect(chef_run).to include_recipe("swpr_dev::#{recipe}")
    end
  end

  it "sets memcached to listen on localhost" do
    expect(chef_run.node["memcached"]["listen"]).to eq("127.0.0.1")
  end
end
