module Kucoin
  module Models
    class Fill < Base
      
      MAPPING  =   {
        symbol:           :string,
        trade_id:         :string,
        order_id:         :string,
        counter_order_id: :string,
        side:             :symbol,
        price:            :float,
        size:             :float,
        funds:            :float,
        type:             :symbol,
        fee:              :float,
        fee_currency:     :string,
        stop:             :symbol,
        liquidity:        :symbol,
        force_taker:      :boolean,
        created_at:       :time
      }
      
    end
  end
end
