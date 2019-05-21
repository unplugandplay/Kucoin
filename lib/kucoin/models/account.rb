module Kucoin
  module Models
    class Account < Base
      MAPPING  =   {
        balance:                    :float,
        available:                  :float,
        holds:                      :float,
        currency:                   :string,
        id:                         :string,
        type:                       :string
      }
    end
  end
end
