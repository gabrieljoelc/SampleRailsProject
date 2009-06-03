module FlickrAware
  def self.invoke(method,params = {})
    url = "http://api.flickr.com/services/rest/?method=#{method}&api_key=#{FLICKR_CONFIG[:api_key]}"
    params.each_pair { |k,v| url += "&#{k.to_s}=#{URI.escape(v)}"} # k may be a symbol
      
    # puts url
    r = Net::HTTP.get_response(URI.parse(url))
    if r.kind_of? Net::HTTPSuccess
      d = REXML::Document.new(r.body)    
      return d if d.root.attributes["stat"] == "ok"
    end
    return nil 
  end
end
