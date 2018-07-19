require 'rubygems'
require 'bundler'

require_relative 'lib/linkchecker'
require_relative 'lib/linkchecker/parser'

Bundler.require(:default)

if $PROGRAM_NAME == __FILE__
  p LinkChecker.new(ARGV[0]).run
  # Parser.new.run
end
