module Bibox
  module Rest
    module Private
      module Transfers
        
        def deposit_address(symbol = "BTC", options: {})
          payload     =   [
            {
              cmd:  "transfer/transferIn",
              body: {coin_symbol: symbol}
            }
          ]
          
          response    =   parse(post("/transfer", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})
        end
        
        def deposits(page: 1, size: 10, filter_type: :all, search: nil, options: {})
          transfers(command: "transfer/transferInList", page: page, size: size, filter_type: filter_type, search: search, options: options)
        end
        
        def withdrawals(page: 1, size: 10, filter_type: :all, search: nil, options: {})
          transfers(command: "transfer/transferOutList", page: page, size: size, filter_type: filter_type, search: search, options: options)
        end

        def transferInfo(symbol = "BTC", options: {})
          payload = [
            {
              cmd:  'transfer/transferInfo',
              body: {coin_symbol: symbol}
            }
          ]

          response  = parse(post("/transfer", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})
        end
        
        def transfers(command:, page: 1, size: 10, filter_type: :all, search: nil, options: {})
          params      =   {
            page:         page,
            size:         size,
            filter_type:  ::Bibox::Models::Transfer::STATUSES[filter_type],
            search:       search,
          }
          
          params.delete_if { |key, value| value.nil? }
          
          payload     =   [
            {
              cmd:  command,
              body: params
            }
          ]
          
          response    =   parse(post("/transfer", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})&.fetch("items", [])
          ::Bibox::Models::Transfer.parse(response) if response
        end
      
      end
    end
  end
end
