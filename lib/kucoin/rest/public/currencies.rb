module Kucoin
  module Rest
    module Public
      module Currencies
        
        def exchange_rates(options: {})
          get("/open/currencies", options: options)&.dig("data", "rates")
        end
      
      end
    end
  end
end
