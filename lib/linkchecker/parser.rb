class Parser
  @@elem = 'a,img,link,frame,iframe,script,source,track'.freeze

  def initialize(url)
    @url = url
  end

  def run
    doc = Nokogiri::HTML(HTTParty.get(@url))
    tags = doc.search(@@elem)
    urls = filter(tags)
    join(urls)
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

  def join(urls)
    urls.map { |link| link =~ /^http/ ? link : URI.join(@url, link).to_s }.uniq
  end
end
