module Bibox
  module Rest
    module Private
      module Assets
                
        def coin_list(options: {})
          payload     =   [
            {
              cmd:  "transfer/coinList",
              body: {}
            }
          ]
          
          response    =   parse(post("/transfer", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", [])
          ::Bibox::Models::Asset.parse(response) if response&.any?
        end
        
        def assets(options: {})
          payload     =   [
            {
              cmd:  "transfer/assets",
              body: {select: 1}
            }
          ]
          
          response    =   parse(post("/transfer", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})
          ::Bibox::Models::UserAssets.new(response) if response
        end
      
      end
    end
  end
end
