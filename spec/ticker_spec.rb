require 'spec_helper'

describe Kucoin::Rest::Client do
  describe :ticker, vcr: {cassette_name: 'kucoin/ticker'} do
    let(:client) { Kucoin::Rest::Client.new }
    let(:ticker) { client.ticker("HPB-ETH") }
    
    expectations = {
      buy:              0.005491,
      change:           -0.00096,
      change_rate:      -0.1488,
      coin_type:        "HPB",
      coin_type_pair:   "ETH",
      datetime:         Time.new(2018, 02, 20, 19, 02, 28, 0),
      fee_rate:         0.001,
      high:             0.006579,
      last_deal_price:  0.005491,
      low:              0.005491,
      sell:             0.005568,
      sort:             0,
      symbol:           "HPB-ETH",
      trading:          true,
      vol:              61104.1427,
      vol_value:        366.86616079
    }

    it { expect(ticker).to be_a_kind_of(::Kucoin::Models::Ticker) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(ticker.send(key)).to eq value
      end
    end

  end
end
