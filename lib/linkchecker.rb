require_relative 'linkchecker/parser'

class LinkChecker
  def initialize(url)
    @url = url
    puts url.to_s.yellow
  end

  def run
    arr = Parser.new(@url).run
    arr_codes = [] # for test purpose
    arr.each do |a|
      code = HTTParty.get(a).code
      if code < 300
        puts code.to_s.green + "\t" + a
      elsif code < 400
        puts code.to_s.yellow + "\t" + a
      else
        puts code.to_s.red + "\t" + a
      end
      arr_codes << code
    end
    arr_codes
  end
end
