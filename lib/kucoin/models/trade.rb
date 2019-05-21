module Kucoin
  module Models
    class Trade < Base
      MAPPING           =   {
        sequence: :string,
        side:     :symbol,
        size:     :float,
        price:    :float,
        time:     :time
      }

    end
  end
end
