require 'rubygems'
require 'bundler'

CHAT_BOT_ENV = ENV.fetch('CHAT_BOT_ENV', 'development')
Bundler.setup(:default, CHAT_BOT_ENV.to_sym)

ROOT_PATH = File.expand_path('../..', __FILE__)
APP_PATH = File.join(ROOT_PATH, 'app')

$:.unshift File.join(APP_PATH, __FILE__)

require File.join(ROOT_PATH, 'config', 'database')

Dir[File.join(APP_PATH, "**/*.rb")].each { |f| require f }
