require 'net/http'
require 'cgi'

class GoogleSet
  SETS_DOMAIN = 'labs.google.com'
  SETS_PATH   = '/sets?hl=en&btn=Large+Set'
  
  attr_accessor :items
  
  def initialize(*args)
    @params = args.inject({}) do |m,i|
      m["q#{m.size}"] = i
      m
    end
  end
  
  def fetch
    path   = SETS_PATH + '&' + query_string
    result = Net::HTTP.start(SETS_DOMAIN, 80) { |http| http.get(path) }
    result.body.scan(%r{<a href="http://www\.google\.com/search\?hl=en&amp;q=[^"]+">(.*?)</a>}).map {|i| i.to_s}
  end
  
  protected
    
    def query_string
      @params.map {|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
    end
end
