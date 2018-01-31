module Bibox
  module Rest
    module Errors
      
      def error?(response)
        if response.is_a?(Hash) && response.has_key?("error")
          error     =   response.fetch("error", {})
          code      =   error.fetch("code", nil)
          message   =   error.fetch("msg", nil)
          ::Bibox::Errors::MAPPING.fetch(code, nil)&.call
        end
      end
            
    end
  end  
end
