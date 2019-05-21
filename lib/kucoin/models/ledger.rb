module Kucoin
  module Models
    class Ledger < Base

      MAPPING  =   {
        created_at: :time,
        amount: :float,
        biz_type: :string,
        balance: :float,
        fee: :float,
        context: :json,
        currency: :string,
        direction: :symbol
      }
      
    end
  end
end
