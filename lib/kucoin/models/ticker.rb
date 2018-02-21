module Kucoin
  module Models
    class Ticker < Base
      MAPPING  =   {
        coin_type:        :string,
        trading:          :boolean,
        symbol:           :string,
        last_deal_price:  :float,
        buy:              :float,
        sell:             :float,
        change:           :float,
        coin_type_pair:   :string,
        sort:             :integer,
        fee_rate:         :float,
        vol_value:        :float,
        high:             :float,
        datetime:         :time,
        vol:              :float,
        low:              :float,
        change_rate:      :float,
        stick:            :boolean,
        fav:              :boolean
      }
    end
  end
end
