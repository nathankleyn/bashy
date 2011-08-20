require "simplecov"
SimpleCov.start
require "rspec"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and ./helpers, and their subdirectories.
Dir["./lib/bashy.rb"].each { |f| require f }
Dir["./spec/{support,helpers}/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before(:all) { }
  config.before(:each) { }
end
