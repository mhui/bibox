module Bibox
  module Models
    class OHLCV < Base
      
      MAPPING   =   {
        time:   :time,
        open:   :float,
        high:   :float,
        low:    :float,
        close:  :float,
        vol:    :float
      }

    end
  end
end
