module Kucoin
  module Models
    class Ticker < Base
      
      MAPPING  =   {
        symbol:       :string,
        high:         :float,
        vol:          :float,
        last:         :float,
        low:          :float,
        buy:          :float,
        sell:         :float,
        change_price: :float,
        change_rate:  :float,
        vol_value:    :float,
        time:         :time,
      }
      
    end
  end
end
