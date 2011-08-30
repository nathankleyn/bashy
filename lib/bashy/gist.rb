require 'net/https'
require 'uri'
require 'json'

module Bashy
  class Gist
  
    GIST_API_ROOT = "https://api.github.com/gists"
    
    attr_accessor :id, :json
    
    def initialize(id)
      @id = id
      get_gist
    end
    
    class << self
      def create
        
      end
      
    private
      
      def api_call(type, uri)
        http_session = Net::HTTP.new(uri.host, uri.port)
        http_session.use_ssl = true
        http_session.start do |http|
          http.send(type, uri.path)
        end
      end
    end
    
    def git_pull_url
      json["git_pull_url"]
    end
    
    def revision
      json["history"][0]["version"]
    end
    
    alias_method :version, :revision
    
    def files
      json["files"]
    end
    
  private
    
    def get_gist
      response = self.class.send(:api_call, :get, URI.parse("#{GIST_API_ROOT}/#{id}"))
      case response.code.to_i
      when 200...300
        self.json = JSON.parse(response.body)
      else
        raise InvalidGistResponseError
      end
    end
    
  end # class
end # module
