require 'spec_helper'

describe Kucoin::Rest::Client do
  before { setup_kucoin }
  let(:client) { Kucoin::Rest::Client.new }
  
  describe :limit_buy, vcr: {cassette_name: 'kucoin/orders/limit/buy'} do
    let(:response) { client.create_buy_order("XRP-USDT", price: 0.10, size: 0.8) }
    
    it { expect(response).to be_a_kind_of String }
    it { expect(response).to eq "5ce430474c06871c7be99af9" }
  end
  
  describe :limit_sell, vcr: {cassette_name: 'kucoin/orders/limit/sell'} do
    let(:response) { client.create_sell_order("USDT-NUSD", price: 10, size: 0.24) }
    
    it { expect(response).to be_a_kind_of String }
    it { expect(response).to eq "5ce431a9c788c65667ffef5d" }
  end
  
  describe :market_buy, vcr: {cassette_name: 'kucoin/orders/market/buy'} do
    let(:response) { client.create_buy_order("VET-USDT", type: :market, size: 10) }
    
    it { expect(response).to be_a_kind_of String }
    it { expect(response).to eq "5ce44806c788c65667046597" }
  end
  
  describe :market_sell, vcr: {cassette_name: 'kucoin/orders/market/sell'} do
    let(:response) { client.create_sell_order("USDT-NUSD", type: :market, size: 0.01) }
    
    it { expect(response).to be_a_kind_of String }
    it { expect(response).to eq "5ce44250cdaba44800fcecf5" }
  end
  
  describe :cancel_order, vcr: {cassette_name: 'kucoin/orders/cancel'} do
    let(:response) { client.cancel_order("5ce430474c06871c7be99af9").first }
    
    it { expect(response).to be_a_kind_of String }
    it { expect(response).to eq "5ce430474c06871c7be99af9" }
  end
  
  describe :cancel_all_orders, vcr: {cassette_name: 'kucoin/orders/cancel_all'} do
    let(:response) { client.cancel_all_orders("XRP-USDT").first }
    
    it { expect(response).to be_a_kind_of String }
    it { expect(response).to eq "5ce430dfcdaba44800f96a69" }
  end
  
end
