class Resolver
  def initialize(url)
    @url = url
  end

  def run
    response = HTTParty.get(@url)
    code = response.code
    { url: @url, code: code }
  end
end
