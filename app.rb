require 'rubygems'
require 'bundler'

require_relative 'lib/linkchecker'
require_relative 'lib/linkchecker/parser'

Bundler.require(:default)

if __FILE__ == $0 
   LinkChecker.new(ARGV[0]).run
 # Parser.new.run
end
