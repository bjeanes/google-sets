require 'open-uri'
require 'cgi'

class GoogleSet
  SETS_PATH = 'http://labs.google.com/sets?hl=en&btn=Large+Set&'
  
  attr_accessor :items
  
  def initialize(*args)
    @params = args.inject({}) do |m,i|
      m["q#{m.size}"] = i
      m
    end
  end
  
  def fetch
    path   = SETS_PATH + query_string
    result = open(path).read
    result.scan(%r{<a href="http://www\.google\.com/search\?hl=en&amp;q=[^"]+">(.*?)</a>}).map {|i| i.to_s}
  end
  
  protected
    
  def query_string
    @params.map {|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
  end
end
