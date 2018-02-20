module Kucoin
  module Models
    class Balance < Base
      MAPPING  =   {
        coin_type:          :string,
        balance:            :float,
        balance_str:        :string,
        freeze_balance:     :float,
        freeze_balance_str: :string
      }
    end
  end
end
