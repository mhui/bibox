module Bibox
  module Rest
    module Public
      module Trades
      
        def trades(pair: "BIX_ETH", size: 200, options: {})
          path        =   "/mdata"
          params      =   {cmd: "deals", pair: pair, size: size}
          response    =   parse(get(path, params: params, options: options))&.fetch("result", {})
          ::Bibox::Models::Trade.parse(response) if response
        end
      
      end
    end
  end
end
