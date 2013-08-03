require "sequel"
require "pathname"
require "yaml"

rack_env = ENV["RACK_ENV"] || "development"

db_config = YAML::load(Pathname.new("config/database.yml").open)
env_config = db_config[rack_env]

db_url = env_config["url"]
max_connections = ENV["MAX_CONNECTIONS"] || env_config["max_connections"] || 4

DB = Sequel.connect(db_url, max_connections: max_connections)

if ENV["SQL"]
  require "logger"
  DB.loggers << Logger.new($stdout)
end

Sequel.extension :blank
