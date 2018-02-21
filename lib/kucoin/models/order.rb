module Kucoin
  module Models
    class Order < Base
      attr_accessor :deals
      
      MAPPING  =   {
        id:                   :string,
        type:                 :symbol,
        direction:            :symbol,
        created_at:           :time,
        updated_at:           :time,
        price:                :float,
        pending_amount:       :float,
        deal_amount:          :float,
        deal_value_total:     :float,
        coin_type:            :string,
        fee_total:            :float,
        user_oid:             :string,
        coin_type_pair:       :string,
        deal_price_average:   :float
      }
      
      INDEX_MAPPING = {
        0 => :created_at,
        1 => :type,
        2 => :price,
        3 => :pending_amount,
        4 => :deal_amount,
        5 => :id
      }
      
      def initialize(hash)
        super(hash)
        
        self.id       =   ::Kucoin::Utilities::Parsing.convert_value(hash.fetch("oid", hash.fetch("orderOid", nil)), :string)    if self.id.to_s.empty?
        self.price    =   ::Kucoin::Utilities::Parsing.convert_value(hash.fetch("price", hash.fetch("orderPrice", nil)), :float) if self.price.nil?
        
        dealt         =   hash.dig("dealOrders", "datas")
        self.deals    =   ::Kucoin::Models::Trade.parse(response) if dealt && dealt.is_a?(Array) && dealt.any?
      end
      
      def self.parse(response)
        orders              =   []
        
        response&.each do |item|
          data              =   {}
          
          item.each_with_index do |value, index|
            data[INDEX_MAPPING[index]] = value
          end
          
          orders << ::Kucoin::Models::Order.new(data)
        end
        
        return orders
      end
      
      def self.parse_map(response)
        orders        =     []
        
        response&.each do |type, collection|
          collection.each do |item|
            orders << ::Kucoin::Models::Order.new(item)
          end
        end
        
        return orders
      end
      
    end
  end
end
