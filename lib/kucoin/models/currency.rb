module Kucoin
  module Models
    class Currency < Base
      
      MAPPING  =   {
        withdrawal_min_fee:  :float,
        precision:           :float,
        name:                :string,
        full_name:           :string,
        currency:            :string,
        withdrawal_min_size: :float,
        is_withdraw_enabled: :boolean,
        is_deposit_enabled:  :boolean
      }
      
    end
  end
end
