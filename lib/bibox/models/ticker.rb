module Bibox
  module Models
    class Ticker < Base
      MAPPING  =   {
        buy:         :float,
        sell:        :float,
        high:        :float,
        low:         :float,
        last:        :float,
        vol:         :float,
        timestamp:   :time,
        last_cny:    :float,
        last_usd:    :float,
        percent:     :string,
      }
    end
  end
end
