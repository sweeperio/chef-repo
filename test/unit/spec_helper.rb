require "chefspec"
require "chefspec/berkshelf"

Dir["./test/unit/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.log_level = :fatal
  config.platform  = "ubuntu"
  config.version   = "14.04"

  config.before(:each) do
    stub_command("which sudo")
    stub_command("dpkg -s memcached")
    stub_command("getent passwd memcache")
  end
end
