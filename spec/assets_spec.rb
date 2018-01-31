require 'spec_helper'

describe Bibox::Rest::Client do
  before { setup_bibox }
  let(:client) { Bibox::Rest::Client.new }
  
  describe :coin_list, vcr: {cassette_name: 'bibox/assets/coin_list'} do
    let(:assets) { client.coin_list }
    let(:asset) { assets.first }
    
    it { expect(assets).to be_a_kind_of Array }
    it { expect(assets.count).to eq 41 }

    expectations = {
      id:               "42",
      symbol:           "BTC",
      name:             "Bitcoin",
      icon_url:         "https://res.linkcoin.pro/coinicon/BTC.png",
      describe_url:     nil,
      total_balance:    0.0,
      balance:          0.0,
      freeze:           0.0,
      enable_withdraw:  true,
      enable_deposit:   true,
      confirm_count:    3,
      btc_value:        0.0,
      cny_value:        0.0,
      usd_value:        0.0,
    }

    it { expect(asset).to be_a_kind_of(::Bibox::Models::Asset) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(asset.send(key)).to eq value
      end
    end
  end
  
  describe :assets, vcr: {cassette_name: 'bibox/assets/assets'} do
    let(:user_assets) { client.assets }
    let(:assets) { user_assets.assets }
    let(:asset) { assets.first }
    
    it { expect(user_assets).to be_a_kind_of ::Bibox::Models::UserAssets }
    
    it { expect(assets).to be_a_kind_of Array }
    it { expect(assets.count).to eq 3 }
    
    expectations = {
      symbol:     "BIX",
      btc_value:  0.06887,
      cny_value:  4420.08,
      usd_value:  698.81,
      balance:    500.0,
      freeze:     0.0,
    }

    it { expect(asset).to be_a_kind_of(::Bibox::Models::Asset) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(asset.send(key)).to eq value
      end
    end
  end
  
end
