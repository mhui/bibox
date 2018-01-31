require 'spec_helper'

describe Bibox::Rest::Client do
  describe :trades, vcr: {cassette_name: 'bibox/trades'} do
    let(:client) { Bibox::Rest::Client.new }
    let(:trades) { client.trades }
    let(:trade) { trades.first }
    
    it { expect(trades).to be_a_kind_of Array }
    it { expect(trades.count).to eq 200 }
    
    expectations = {
      pair:       "BIX_ETH",
      price:      0.0013075,
      amount:     7.1892,
      time:       Time.new(2018, 01, 30, 15, 55, 35, 0),
      side:       :buy
    }
    
    it { expect(trade).to be_a_kind_of(::Bibox::Models::Trade) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(trade.send(key)).to eq value
      end
    end

  end
end
