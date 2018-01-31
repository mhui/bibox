module Bibox
  module Models
    class Trade < Base
      MAPPING   =   {
        pair:      :string,
        price:     :float,
        amount:    :float,
        time:      :time,
        side:      {enum: {1 => :buy, 2 => :sell}}
      }
    end
  end
end
