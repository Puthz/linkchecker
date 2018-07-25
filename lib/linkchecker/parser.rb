class Parser
  ELEM = "a,img,link,frame,iframe,script,source,track".freeze

  def initialize(url)
    @url = url
  end

  def run
    return [] if @url.nil? || @url.empty?

    doc = Nokogiri::HTML(HTTParty.get(@url))
    tags = doc.search(ELEM)
    urls = filter(tags)
    join(urls)
  end

  private

  def filter(tags)
    tags.map do |tag|
      case tag.name
      when "a" || "link"
        tag["href"]
      when "img" || "frame" || "iframe" || "script" || "source" || "track"
        tag["src"]
      end
    end .compact
  end

  def join(urls)
    urls.map { |link| /^http/.match?(link) ? link : URI.join(@url, link).to_s }.uniq
  end
end
