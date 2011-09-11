require "./lib/bashy/patches/hash"
require "./lib/bashy/patches/kernel"
require "./lib/bashy/patches/string"

require "./lib/bashy/config"

require "./lib/bashy/base"
require "./lib/bashy/cli"
require "./lib/bashy/command_proxy"
require "./lib/bashy/exceptions"
require "./lib/bashy/gist"
require "./lib/bashy/logger"

Dir["./lib/bashy/commands/**/*.rb"].each { |f| p f; require f }
