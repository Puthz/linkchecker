require "colorize"

class Reporter
  def initialize(url)
    @url = url
  end

  def run
    puts @url.to_s.yellow
  end

  def report(result)
    link = result[:url]
    code = result[:code]
    if code < 300
      puts code.to_s.green + "\t" + link
    elsif code < 400
      puts code.to_s.yellow + "\t" + link
    else
      puts code.to_s.red + "\t" + link
    end
  end
end
