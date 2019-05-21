require 'spec_helper'

describe Kucoin::Rest::Client do
  describe :ticker, vcr: {cassette_name: 'kucoin/ticker'} do
    let(:client) { Kucoin::Rest::Client.new }
    let(:ticker) { client.ticker("XRP-USDT") }
    
    expectations = {
      "sequence"=>"1556266889824",
      "bestAsk"=>"0.39627",
      "size"=>"169.7",
      "price"=>"0.39541",
      "bestBidSize"=>"525.29",
      "time"=>1558458401604,
      "bestBid"=>"0.39612",
      "bestAskSize"=>"2459.5806"
    }

    it { expect(ticker).to be_a_kind_of(Hash) }
  
    expectations.each do |key, value|
      it "should have correct value for instance variable #{key}" do
        expect(ticker.fetch(key)).to eq value
      end
    end

  end
end
