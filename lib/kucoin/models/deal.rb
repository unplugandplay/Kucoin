module Kucoin
  module Models
    class Deal < Base
      MAPPING  =   {
        oid:              :string,
        order_oid:        :string,
        coin_type:        :string,
        coin_type_pair:   :string,
        deal_direction:   :string,
        direction:        :string,
        deal_price:       :float,
        amount:           :float,
        deal_value:       :float,
        fee:              :float,
        fee_rate:         :float,
        created_at:       :time
      }
    end
  end
end
