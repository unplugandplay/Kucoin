module Kucoin
  module Models
    class OrderBook
      attr_accessor :symbol, :timestamp, :asks, :bids
      
      INDEX_MAPPING         =   {
        0 => :price,
        1 => :amount,
        2 => :volume
      }
      
      def initialize(hash, type: :nil)
        self.symbol         =   hash.fetch("symbol", nil)
        self.timestamp      =   ::Kucoin::Utilities::Parsing.epoch_to_time(hash.fetch("timestamp", nil), ms: true) if hash.has_key?("timestamp") && !hash.fetch("timestamp", nil).to_s.empty?

        self.bids           =   []
        self.asks           =   []

        process(hash.fetch("data", []), type: type)
      end
      
      def process(data, type: nil)
        pp data
        
        if data.is_a?(Hash)
          ["BUY", "SELL"].each do |type|
            process_orders(data.fetch(type.to_s, []), type: type)
          end
        elsif data.is_a?(Array)
          process_orders(data, type: type)
        end
      end
      
      def process_orders(orders, type: "BUY")
        orders.each do |item|
          data              =   {}
          
          item.each_with_index do |value, index|
            data[INDEX_MAPPING[index]] = value
          end
          
          case type
            when "BUY"
              self.bids << data
            when "SELL"
              self.asks << data
          end
        end
      end

    end
  end
end
