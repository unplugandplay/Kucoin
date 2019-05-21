module Kucoin
  module Models
    class Order < Base
      
      MAPPING  =   {
        symbol:         :string,
        hidden:         false,
        op_type:        :string,
        fee:            :float,
        channel:        :string,
        fee_currency:    :string,
        type:           :symbol,
        is_active:       :boolean,
        created_at:     :time,
        visible_size:   :integer,
        price:          :float,
        iceberg:        :boolean,
        stop_triggered: :boolean,
        funds:          :float,
        id:             :string,
        time_in_force:  :string,
        side:           :symbol,
        deal_size:      :float,
        cancel_after:   :integer,
        deal_funds:     :float,
        stp:            :string,
        post_only:      :boolean,
        stop_price:     :float,
        size:           :float,
        stop:           :string,
        cancel_exist:   :boolean,
        client_oid:     :string
      }
      
    end
  end
end
