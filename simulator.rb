require 'bundler'

Bundler.setup(:default)
$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

require 'simulator/launcher'
require 'oj'
require 'oj_mimic_json'
require 'multi_json'
require 'dotenv'
Dotenv.load
MultiJson.use(:oj)


simulator = Simulator::Launcher.new
simulator.execute
