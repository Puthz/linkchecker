require_relative 'linkchecker/parser'

class LinkChecker

  def initialize(url)
    @url = url
    puts url.to_s.yellow
  end

  def run
    ary = Parser.new(@url).run
    ary_codes = Array.new # for test purpose
    ary.each { |a|
      response = HTTParty.get(a)
      code = response.code
      case 
        when code < 300
          puts code.to_s.green + "\t" + a
        when code < 400
          puts code.to_s.yellow + "\t" + a 
        else
          puts code.to_s.red + "\t" + a 
      end
      ary_codes << code
    }
  ary_codes
  end

end
