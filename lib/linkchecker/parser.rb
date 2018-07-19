class Parser
  def initialize(url)
    @url = url
    # @url = 'https://slack.com/'
  end

  def run
    doc = Nokogiri::HTML(HTTParty.get(@url))
    tags = doc.search('a,img,link,frame,iframe,script,source,track')
    urls = filter(tags)
    relatives(urls)
  end

  def filter(tags)
    tags.map do |tag|
      case tag.name
      when 'a' || 'link'
        tag['href']
      when 'img' || 'frame' || 'iframe' || 'script' || 'source' || 'track'
        tag['src']
      end
    end .compact
  end

  def relatives(urls)
    urls.map { |link| link =~ /^http/ ? link : URI.join(@url, link).to_s }.uniq
  end
end
