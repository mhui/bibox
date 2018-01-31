require 'spec_helper'

describe Bibox::Rest::Client do
  
  describe :order_book, vcr: {cassette_name: 'bibox/order_book/simple'} do
    let(:client) { Bibox::Rest::Client.new }
    let(:order_book) { client.order_book }
    let(:ask) { order_book.asks.first }
    
    it { expect(order_book).to be_a_kind_of ::Bibox::Models::OrderBook }
    it { expect(order_book.asks).to be_a_kind_of Array }
    it { expect(order_book.asks.size).to eq 117 }
    
    expectations = {
      price:    0.00131314,
      volume:   65.0,
      value:    0.0853541
    }
    
    it { expect(ask).to be_a_kind_of(Hash) }
  
    expectations.each do |key, value|
      it "should have correct value for key #{key}" do
        expect(ask.fetch(key, nil)).to eq value
      end
    end
  end
  
  describe :extended_order_book, vcr: {cassette_name: 'bibox/order_book/extended'} do
    let(:client) { Bibox::Rest::Client.new }
    let(:order_book) { client.extended_order_book }
    let(:ask) { order_book.asks.first }
    
    it { expect(order_book).to be_a_kind_of ::Bibox::Models::OrderBook }
    it { expect(order_book.asks).to be_a_kind_of Array }
    it { expect(order_book.asks.size).to eq 110 }
    
    expectations = {
      price:    0.0013048,
      volume:   22.7772,
      value:    0.02971969056
    }
    
    it { expect(ask).to be_a_kind_of(Hash) }
  
    expectations.each do |key, value|
      it "should have correct value for key #{key}" do
        expect(ask.fetch(key, nil)).to eq value
      end
    end
  end
  
end
