require 'spec_helper'

describe Bibox::Rest::Client do
  before { setup_bibox }
  let(:client) { Bibox::Rest::Client.new }
  
  describe :buy, vcr: {cassette_name: 'bibox/orders/buy'} do
    let(:order_id) { client.buy(pair: "BIX_ETH", price: 0.00100000, amount: 0.0003) }
    
    it { expect(order_id).to be_a_kind_of String }
    it { expect(order_id).to eq "189689340" }
  end
  
  describe :sell, vcr: {cassette_name: 'bibox/orders/sell'} do
    let(:order_id) { client.sell(pair: "BIX_ETH", price: 0.00200000, amount: 10) }
    
    it { expect(order_id).to be_a_kind_of String }
    it { expect(order_id).to eq "189689365" }
  end
  
  describe :invalid_cancel, vcr: {cassette_name: 'bibox/orders/invalid_cancel'} do
    it { expect { client.cancel_order("189689365") }.to raise_error Bibox::Errors::InvalidOrderError }
  end

  describe :valid_cancel, vcr: {cassette_name: 'bibox/orders/valid_cancel'} do
    it { expect(client.cancel_order("189714906")).to be_a_kind_of TrueClass }
  end
  
  describe :pending_orders, vcr: {cassette_name: 'bibox/orders/pending'} do
    let(:orders) { client.pending_orders }
    let(:order) { orders.first }
    
    it { expect(orders).to be_a_kind_of Array }
    it { expect(orders.count).to eq 2 }
    
    expectations = {
      id:               "188571145",
      created_at:       Time.new(2018, 01, 30, 14, 07, 42, 0),
      account_type:     0,
      coin_symbol:      "HPB",
      currency_symbol:  "ETH",
      order_side:       :buy,
      order_type:       2,
      price:            0.00721957,
      amount:           137.9225,
      money:            0.99574114,
      deal_amount:      0.0,
      deal_percent:     "0.00%",
      status:           1,
      unexecuted:       137.9225
    }

    it { expect(order).to be_a_kind_of(::Bibox::Models::Order) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(order.send(key)).to eq value
      end
    end
  end
  
  describe :order_history, vcr: {cassette_name: 'bibox/orders/history'} do
    let(:orders) { client.order_history }
    let(:order) { orders.first }
    
    it { expect(orders).to be_a_kind_of Array }
    it { expect(orders.count).to eq 6 }

    expectations = {
      id:               "202901462",
      created_at:       Time.new(2018, 01, 30, 16, 48, 8, 0),
      account_type:     0,
      coin_symbol:      "HPB",
      currency_symbol:  "ETH",
      order_side:       :buy,
      order_type:       2,
      price:            0.00721957,
      amount:           15.7257,
      money:            0.11353279,
      fee:              0.0,
      pay_bix:          true,
      fee_symbol:       "BIX"
    }

    it { expect(order).to be_a_kind_of(::Bibox::Models::Order) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(order.send(key)).to eq value
      end
    end
  end
  
end
