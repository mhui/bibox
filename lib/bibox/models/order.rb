module Bibox
  module Models
    class Order < Base      
      MAPPING   =   {
        id:                :string,
        created_at:        :time,
        account_type:      :integer,
        coin_symbol:       :string,
        currency_symbol:   :string,
        fee_symbol:        :string,
        order_side:        {enum: {1 => :buy, 2 => :sell}},
        order_type:        :integer,
        price:             :float,
        amount:            :float,
        money:             :float,
        fee:               :float,
        pay_bix:           :boolean,
        deal_price:        :float,
        deal_amount:       :float,
        deal_money:        :float,
        deal_percent:      :string,
        status:            :integer,
        unexecuted:        :float
      }
      
      ORDER_SIDES     =   {
        buy:  1,
        sell: 2
      }
      
      ORDER_TYPES     =   {
        market: 1, # NOT VERIFIED! There's no API documentation so it's just a guess for now.
        limit: 2
      }
      
    end
  end
end
