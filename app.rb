require 'rubygems'
require 'bundler'

require_relative 'lib/links'
require_relative 'lib/links/parser'

Bundler.require(:default)

if __FILE__ == $0 
   Links.new(ARGV[0]).run
 # Parser.new.run
end
