require 'spec_helper'

describe Bibox::Rest::Client do
  describe :pair, vcr: {cassette_name: 'bibox/pair'} do
    let(:client) { Bibox::Rest::Client.new }
    let(:pair) { client.pair }
    
    expectations = {
      id:               "2",
      coin_symbol:      "BIX",
      currency_symbol:  "ETH",
      last:             0.00130888,
      high:             0.00145,
      low:              0.001288,
      change:           "-0.00006042",
      percent:          "-4.41%",
      amount:           6135.64,
      last_cny:         9.16,
      high_cny:         10.15,
      low_cny:          9.01,
      last_usd:         1.45,
      high_usd:         1.6,
      low_usd:          1.43
    }
    
    it { expect(pair).to be_a_kind_of(::Bibox::Models::Pair) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(pair.send(key)).to eq value
      end
    end

  end
  
  describe :pairs, vcr: {cassette_name: 'bibox/pairs'} do
    let(:client) { Bibox::Rest::Client.new }
    let(:pairs) { client.pairs }
    let(:pair) { pairs.first }
    
    it { expect(pairs).to be_a_kind_of Array }
    it { expect(pairs.size).to eq 70 }
    
    expectations = {
      id:               "1",
      coin_symbol:      "BIX",
      currency_symbol:  "BTC",
      last:             0.00014056,
      high:             0.0001534,
      low:              0.00013751,
      change:           "-0.00000180",
      percent:          "-1.26%",
      amount:           639.56,
      last_cny:         9.16,
      high_cny:         10.0,
      low_cny:          8.96,
      last_usd:         1.45,
      high_usd:         1.58,
      low_usd:          1.42
    }
    
    it { expect(pair).to be_a_kind_of(::Bibox::Models::Pair) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(pair.send(key)).to eq value
      end
    end
    
  end
end
