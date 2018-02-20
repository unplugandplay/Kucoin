module Kucoin
  module Models
    class OHLCV < Base
      MAPPING   =   {
        timestamp:  :time,
        open:       :float,
        high:       :float,
        low:        :float,
        close:      :float,
        volume:     :float
      }
      
      def self.parse(data)
        ohlcvs      =   []
        
        timestamps  =   data.fetch("t", [])
        opens       =   data.fetch("o", [])
        highs       =   data.fetch("h", [])
        lows        =   data.fetch("l", [])
        closes      =   data.fetch("c", [])
        volumes     =   data.fetch("v", [])
        
        if timestamps&.any? && opens&.any? && highs&.any? && lows&.any? && closes&.any? && volumes&.any?
          timestamps.each_with_index do |timestamp, index|
            item    =   {timestamp: timestamp, open: opens[index], high: highs[index], low: lows[index], close: closes[index], volume: volumes[index]}  
            ohlcvs <<   ::Kucoin::Models::OHLCV.new(item)
          end
        end
        
        return ohlcvs
      end
      
    end
  end
end
