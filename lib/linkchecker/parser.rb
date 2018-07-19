class Parser
  def initialize(url)
    @url = url
    @attr = 'a,img,link,frame,iframe,script,source,track'.freeze
  end

  def run
    doc = Nokogiri::HTML(HTTParty.get(@url))
    tags = doc.search(@attr)
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
