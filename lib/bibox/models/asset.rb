module Bibox
  module Models
    class Asset < Base      
      MAPPING     =   {
        id:                 :string,
        symbol:             :string,
        icon_url:           :string,
        describe_url:       :string,
        name:               :string,
        enable_withdraw:    :boolean,
        enable_deposit:     :boolean,
        confirm_count:      :integer,
        total_balance:      :float,
        balance:            :float,
        freeze:             :float,
        btc_value:          :float,
        cny_value:          :float,
        usd_value:          :float
      }
      
      def initialize(hash)
        super(hash)
        
        self.symbol   =   hash.fetch("coin_symbol", nil) if self.symbol.to_s.empty? && hash.has_key?("coin_symbol")
      end
      
    end
  end
end
