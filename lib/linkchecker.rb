require "colorize"
require_relative 'linkchecker/parser'

class LinkChecker
  def initialize(url)
    @url_code = []
    @url = url
    @parser = Parser.new(@url)
  end

  def run
    puts @url.to_s.yellow
    @parser.run.each do |url|
      code = HTTParty.get(url).code
      show(url, code)
      @url_code << { url: url, code: code }
    end
    @url_code
  end

  def show(url, code)
    if code < 300
      puts code.to_s.green + "\t" + url
    elsif code < 400
      puts code.to_s.yellow + "\t" + url
    else
      puts code.to_s.red + "\t" + url
     end
  end
end
