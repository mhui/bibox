module Bibox
  module Rest
    module Public
      module Pairs
        
        def pair(pair: "BIX_ETH", options: {})
          path        =   "/mdata"
          params      =   {cmd: "market", pair: pair}
          response    =   parse(get(path, params: params, options: options))&.fetch("result", {})
          ::Bibox::Models::Pair.new(response) if response
        end
        
        def pairs(options: {})
          path        =   "/mdata"
          params      =   {cmd: "marketAll"}
          response    =   parse(get(path, params: params, options: options))&.fetch("result", {})
          ::Bibox::Models::Pair.parse(response) if response
        end
      
      end
    end
  end
end
