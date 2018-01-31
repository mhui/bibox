module Bibox
  module Rest
    module Public
      module Ticker
      
        def ticker(pair: "BIX_ETH", options: {})
          path        =   "/mdata"
          params      =   {cmd: "ticker", pair: pair}
          response    =   parse(get(path, params: params, options: options))&.fetch("result", {})
          ::Bibox::Models::Ticker.new(response) if response
        end
      
      end
    end
  end
end
