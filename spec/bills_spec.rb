require 'spec_helper'

describe Bibox::Rest::Client do
  before { setup_bibox }
  let(:client) { Bibox::Rest::Client.new }
  
  describe :bills, vcr: {cassette_name: 'bibox/bills'} do
    let(:bills) { client.bills }
    let(:bill) { bills.first }
    
    it { expect(bills).to be_a_kind_of Array }
    it { expect(bills.count).to eq 22 }
    
    expectations = {
      symbol:         "ETH",
      created_at:     DateTime.new(2018, 01, 30, 17, 39, 39, 0),
      change_amount:  -0.03972255,
      result_amount:  4.0e-07,
      fee:            0.0,
      fee_symbol:     "",
      comment:        "卖出ETH",
      bill_type:      :sell
    }

    it { expect(bill).to be_a_kind_of(::Bibox::Models::Bill) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(bill.send(key)).to eq value
      end
    end
  end
  
  # Create test case for withdrawals when there are withdrawals to test against
  
end
