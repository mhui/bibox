module Bibox
  module Models
    class Pair < Base      
      MAPPING     =   {
        id:                :string,
        coin_symbol:       :string,
        currency_symbol:   :string,
        high:              :float,
        low:               :float,
        last:              :float,
        vol24_h:            :float,
        amount:            :float,
        change:            :string,
        percent:           :string,
        low_cny:           :float,
        high_cny:          :float,
        last_cny:          :float,
        low_usd:           :float,
        high_usd:          :float,
        last_usd:          :float
      }
    end
  end
end
