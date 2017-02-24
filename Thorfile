$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'bundler/setup'
require 'dotenv'

Dotenv.load

Dir.glob('thor/**/*.thor') do |name|
  Thor::Util.load_thorfile(name)
end
