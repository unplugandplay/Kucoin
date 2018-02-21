require 'spec_helper'

describe Kucoin::Rest::Client do
  before { setup_kucoin }
  let(:client) { Kucoin::Rest::Client.new }
  
  describe :buy, vcr: {cassette_name: 'kucoin/orders/buy'} do
    let(:response) { client.create_order("ITC-ETH", type: :buy, price: 0.00011, amount: 100) }
    
    it { expect(response).to be_a_kind_of Hash }
    it { expect(response[:success]).to eq true}
    it { expect(response[:id]).to eq "5a8de8d4003f9b43a9e6ff83" }
  end
  
  describe :sell, vcr: {cassette_name: 'kucoin/orders/sell'} do
    let(:response) { client.create_order("ETH-BTC", type: :sell, price: 0.10000000, amount: 0.0001) }
    
    it { expect(response).to be_a_kind_of Hash }
    it { expect(response[:success]).to eq true}
    it { expect(response[:id]).to eq "5a8de9ed8247274f867a292b" }
  end
  
  describe :cancel_order, vcr: {cassette_name: 'kucoin/orders/cancel'} do
    let(:success) { client.cancel_order("ITC-ETH", type: :buy, order_id: "5a8dea55003f9b447c298a28") }
    
    it { expect(success).to eq true}
  end
  
  describe :cancel_all_orders, vcr: {cassette_name: 'kucoin/orders/cancel_all'} do
    let(:success) { client.cancel_all_orders("ITC-ETH") }
    
    it { expect(success).to eq true}
  end
  
end
