require 'active_record'
require 'yaml'

config = YAML.load(File.read(File.join(ROOT_PATH, "db", "config.yml")))

ActiveRecord::Base.establish_connection(config.fetch(CHAT_BOT_ENV))
