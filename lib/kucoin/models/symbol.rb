module Kucoin
  module Models
    class Symbol < Base
      
      MAPPING  =   {
        symbol:          :string,
        name:            :string,
        base_currency:   :string,
        quote_currency:  :string,
        base_min_size:   :float,
        quote_min_size:  :float,
        base_max_size:   :float,
        quote_max_size:  :float,
        base_increment:  :float,
        quote_increment: :float,
        price_increment: :float,
        fee_currency:    :string,
        enable_trading:  :boolean
      }
      
    end
  end
end
