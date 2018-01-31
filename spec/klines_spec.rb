require 'spec_helper'

describe Bibox::Rest::Client do
  describe :klines, vcr: {cassette_name: 'bibox/klines'} do
    let(:client) { Bibox::Rest::Client.new }
    let(:klines) { client.klines }
    let(:kline) { klines.first }
    
    it { expect(klines).to be_a_kind_of Array }
    it { expect(klines.count).to eq 1000 }
    
    expectations = {
      time:       Time.new(2018, 01, 29, 21, 43, 00, 0),
      open:       0.001394,
      high:       0.00140582,
      low:        0.00138149,
      close:      0.00138149,
      vol:        2128.1609
    }
    
    it { expect(kline).to be_a_kind_of(::Bibox::Models::OHLCV) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(kline.send(key)).to eq value
      end
    end

  end
end
