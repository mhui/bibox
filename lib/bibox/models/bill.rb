module Bibox
  module Models
    class Bill < Base
      MAPPING  =   {
        created_at:    :datetime,
        symbol:        :string,
        change_amount: :float,
        result_amount: :float,
        fee:           :float,
        fee_symbol:    :string,
        comment:       :string,
        bill_type:     {enum: {-1 => :all, 0 => :deposit, 2 => :withdrawal, 3 => :sell, 5 => :buy, 31 => :transfer_in, 32 => :transfer_out}},
      }
      
      BILL_TYPES     =   {
        all:          -1,
        deposit:      0,
        withdrawal:   2,
        sell:         3,
        buy:          5,
        transfer_in:  31,
        transfer_out: 32
      }
    end
  end
end
