

require_relative 'links/parser'

class Links
  def initialize(url)
    @url = url
  end

  def run
    ary = Parser.new(@url).run
    p ary
    ary.each { |a|
    	code = HTTParty.get(a).code
    	case 
	    	when code < 300
	    		puts code.to_s.green + "\t" + a
	    	when code < 400
	    		puts code.to_s.yellow + "\t" + a 
	    	else
	    		puts code.to_s.red + "\t" + a 
	    	end
	}
  end

end

