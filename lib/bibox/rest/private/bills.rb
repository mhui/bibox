module Bibox
  module Rest
    module Private
      module Bills
                
        def bills(coin_id: 0, type: :all, days: 30, page: 1, size: 50, options: {})
          params      =   {
            coin_id:  coin_id,
            type:     ::Bibox::Models::Bill::BILL_TYPES[type],
            days:     days,  
            page:     page,
            size:     size
          }
          
          params.delete_if { |key, value| value.nil? }
          
          payload     =   [
            {
              cmd:  "transfer/bills",
              body: params
            }
          ]
          
          response    =   parse(post("/transfer", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})&.fetch("items", [])
          ::Bibox::Models::Bill.parse(response) if response&.any?
        end
      
      end
    end
  end
end
