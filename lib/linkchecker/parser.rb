class Parser 

	def initialize(url)
		@url = url
		# @url = 'https://slack.com/'
	end

	def run 
		doc = Nokogiri::HTML(HTTParty.get(@url))

		urls = doc.search('a,img,link,frame,iframe,script,source,track')
		.map{ |tag| 
		  case tag.name
		  when 'a'
		    tag['href']
		  when 'img'
		    tag['src']
		  when 'link'
		    tag['href']    
		  when 'frame'
		    tag['src']
		  when 'iframe'
		    tag['src']
		  when 'script'
		    tag['src']
		  when 'source'
		    tag['src']
		  when 'track'
		    tag['src']
		  end}.compact

		 relatives = urls.map{|link| link =~ /^http/ ? link : URI.join(@url,link).to_s} # (link =~ /^\// || link =~ /^\#/)
		 links = relatives.uniq
	end
end
