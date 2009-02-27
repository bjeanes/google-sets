require 'net/http'
require 'cgi'

class GoogleSet
  SETS_DOMAIN = 'labs.google.com'
  SETS_PATH   = '/sets'
  
  attr_accessor :items
  
  def initialize(*args)
    @params = args.inject({}) do |m,i|
      m["q#{m.size}"] = i
      m
    end
  end
  
  def items(reload = false)
    @items = nil if reload
    @items ||= begin 
      Net::HTTP.start(SETS_DOMAIN, 80) { |http| http.get(SETS_PATH + "?" + query_string) }
    end
  end
  
  protected
    
    def query_string
      @params.map {|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
    end
end

puts GoogleSet.new('titania', 'oberon', 'romeo').items