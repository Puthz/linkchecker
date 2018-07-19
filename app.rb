require 'rubygems'
require 'bundler'

require_relative 'lib/linkchecker'
require_relative 'lib/linkchecker/parser'

Bundler.require(:default)

LinkChecker.new(ARGV[0]).run if $PROGRAM_NAME == __FILE__
