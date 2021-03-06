# Derived from David's simple Backpack API library

require 'rubygems'
require 'net/http'
#require 'xmlsimple'
require 'active_support'

class PastieClient
  attr_accessor :nickname, :key
  
  def initialize(nick=nil, key=nil)
    @nick, @key = nick, key
    connect
  end
  
  def connect
    @connection = Net::HTTP.new("pastie.org", 80)
  end
  
  def request(path, parameters = {})
#    parameters = { "token" => @token }.merge(parameters)
    
    response = @connection.post(path , parameters.to_xml.gsub(/<\/?hash>/,""), "Content-Type" => "application/xml", "Accept" => "application/xml")
    
    if response.code =~ /20[01]/
#      result = XmlSimple.xml_in(response.body) rescue response.body
      result=response.body
      result.empty? ? true : result
    else
      raise "Error occured (#{response.code}): #{response.body}"
    end
  end
  alias :r :request

  # returns the id if the paste was saved successfully
  def paste(body, syntax="ruby_on_rails")
    request("/pastes/create", { :paste => { :body => body, :parser => syntax }})
  end
  alias :p :paste
  
end