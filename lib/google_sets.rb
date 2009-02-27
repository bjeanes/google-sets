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
  
  def items(reload = false)
    @items = nil if reload
    @items ||= begin 
      path   = SETS_PATH + '&' + query_string
      result = Net::HTTP.start(SETS_DOMAIN, 80) { |http| http.get(path) }
      result.body.scan(/<a href="http:\/\/www\.google\.com\/search\?hl=en&amp;q=[^"]+">(.*?)<\/a>/).map {|i| i.to_s}
    end
  end
  
  def [](index); items[index]; end
  def size; items.size; end
  def rand; items[Kernel.rand(items.size)]; end
  def to_s; items.join("\n"); end
  def to_a; items.dup; end
  
  protected
    
    def query_string
      @params.map {|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
    end
end

puts GoogleSet.new(*%w{titania oberon romeo}).to_a.inspect