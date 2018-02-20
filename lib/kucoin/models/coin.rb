module Kucoin
  module Models
    class Coin < Base
      MAPPING  =   {
        name:                 :string,
        coin:                 :string,
        info_url:             :string,
        trade_precision:      :integer,
        deposit_remart:       :string,
        confirmation_count:   :integer,
        withdraw_min_fee:     :float,
        withdraw_min_amount:  :float,
        withdraw_fee_rate:    :float,
        withdraw_remart:      :string,
        enable_withdraw:      :boolean,
        enable_deposit:       :boolean
      }
    end
  end
end
