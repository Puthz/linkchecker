require 'rubygems'
require 'bundler'

require_relative 'lib/linkchecker'
require_relative 'lib/linkchecker/parser'

Bundler.require(:default)

class App
  def run(arg)
    LinkChecker.new(arg).run
  end
end

App.new.run(ARGV[0]) if $PROGRAM_NAME == __FILE__
