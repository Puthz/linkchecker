require_relative 'linkchecker/parser'
require_relative 'linkchecker/reporter'
require_relative 'linkchecker/resolver'

class LinkChecker
  def initialize(url, parser: nil)
    @url = url
    @parser = parser ||  Parser.new(@url)
    @reporter = Reporter.new(@url)
  end

  def run
    @reporter.run
    @parser.run.each do |url|
      result = Resolver.new(url).run
      @reporter.report(result)
    end
  end
end
