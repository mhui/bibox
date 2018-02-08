module Bibox
  module Errors
    class Error < StandardError; end;
    class MissingConfigError < Bibox::Errors::Error; end;
    class ParameterError < Bibox::Errors::Error; end;
    class InvalidOrderError < Bibox::Errors::Error; end;
    class ApiNotSupportedError < Bibox::Errors::Error; end;
    class WebsocketError < Bibox::Errors::Error; end;
    class RateLimitError < Bibox::Errors::Error; end;
    
    MAPPING = {
      "2033" => -> { raise ::Bibox::Errors::InvalidOrderError.new("Order operation failed! Order has already completed or has already been revoked (code 2033)") },
      "3000" => -> { raise ::Bibox::Errors::ParameterError.new("Invalid parameters specified (code 3000)") },
      "3011" => -> { raise ::Bibox::Errors::ApiNotSupportedError.new("This method isn't available via the API (code 3011)") },
      "4003" => -> { raise ::Bibox::Errors::RateLimitError.new("The server is busy or a rate limit has been hit.") },
    }
    
  end
end
