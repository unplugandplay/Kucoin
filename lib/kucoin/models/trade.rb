module Kucoin
  module Models
    class Trade < Base
      ARRAY_MAPPING     =   {
        0 => "timestamp",
        1 => "order_type",
        2 => "price",
        3 => "amount",
        4 => "volume"
      }
      
      MAPPING           =   {
        timestamp:  :time,
        order_type: :string,
        price:      :float,
        amount:     :float,
        volume:     :float,
      }
      
      def self.parse(response)
        trades              =   []
        
        response&.each do |item|
          data              =   {}
          
          item.each_with_index do |value, index|
            data[ARRAY_MAPPING[index]] = value
          end
          
          trades << ::Kucoin::Models::Trade.new(data)
        end
        
        return trades
      end

    end
  end
end
