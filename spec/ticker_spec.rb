require 'spec_helper'

describe Bibox::Rest::Client do
  describe :ticker, vcr: {cassette_name: 'bibox/ticker'} do
    let(:client) { Bibox::Rest::Client.new }
    let(:ticker) { client.ticker }
    
    expectations = {
      buy:        0.001313,
      sell:       0.00131652,
      high:       0.00145,
      low:        0.001288,
      last:       0.00131535,
      vol:        4515795.0,
      timestamp:  Time.new(2018, 01, 30, 15, 27, 32, 0),
      last_cny:   9.14,
      last_usd:   1.45,
      percent:    "-2.40%",
    }
    
    it { expect(ticker).to be_a_kind_of(::Bibox::Models::Ticker) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(ticker.send(key)).to eq value
      end
    end

  end
end
