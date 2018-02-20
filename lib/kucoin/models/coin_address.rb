module Kucoin
  module Models
    class CoinAddress < Base
      MAPPING  =   {
        oid:                :string,
        address:            :string,
        context:            :string,
        user_oid:           :string,
        coin_type:          :string,
        created_at:         :time,
        deleted_at:         :time,
        updated_at:         :time,
        last_received_at:   :time
      }
    end
  end
end
