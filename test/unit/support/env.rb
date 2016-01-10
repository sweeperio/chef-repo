shared_context "development environment", env: :development do
  let(:environment) { Chef::Environment.load_from_file("development") }

  before do
    allow_any_instance_of(Chef::Node).to receive(:chef_environment).and_return(environment.name)
    allow(Chef::Environment).to receive(:load).with(environment.name).and_return(environment)
  end
end
