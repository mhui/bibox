module Bibox
  module Rest
    module Public
      module OrderBook
      
        def order_book(pair: "BIX_ETH", size: 200, options: {})
          path        =   "/mdata"
          params      =   {cmd: "depth", pair: pair, size: size}
          response    =   parse(get(path, params: params, options: options))&.fetch("result", {})
          ::Bibox::Models::OrderBook.new(response) if response
        end
      
      end
    end
  end
end
