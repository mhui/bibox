module Bibox
  module Rest
    module Private
      module OrderBook
      
        def extended_order_book(pair: "BIX_ETH", size: 200, options: {})
          payload     =   [
            {
              cmd:  "api/depth",
              body: {pair: pair, size: size}
            }
          ]
          
          response    =   parse(post("/mdata", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})
          ::Bibox::Models::OrderBook.new(response) if response
        end
      
      end
    end
  end
end
