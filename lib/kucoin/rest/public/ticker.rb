module Kucoin
  module Rest
    module Public
      module Ticker
        
        def ticker(symbol, options: {})
          response  = parse(get("/open/tick", params: {symbol: symbol}, options: options))&.fetch("data", {})
          ::Kucoin::Models::Ticker.new(response) if response
        end
      
      end
    end
  end
end
