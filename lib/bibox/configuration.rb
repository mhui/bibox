module Bibox
  class Configuration
    attr_accessor :key, :secret, :faraday
    
    def initialize
      self.key              =   nil
      self.secret           =   nil
      
      self.faraday          =   {
        adapter:    :net_http,
        user_agent: 'Bibox Ruby',
        verbose:    false
      }
    end
    
    def verbose_faraday?
      self.faraday.fetch(:verbose, false)
    end
    
  end
end
