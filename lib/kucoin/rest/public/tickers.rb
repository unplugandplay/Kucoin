module Kucoin
  module Rest
    module Public
      module Tickers
        
        def ticker(symbol, options: {})
          params      =   {symbol: symbol.to_s.upcase}
          
          response    =   get("/market/orderbook/level1", params: params, options: options)&.fetch("data", {})
        end
        
        def tickers(options: {})
          response    =   get("/market/allTickers", options: options)&.dig("data", "ticker")
          ::Kucoin::Models::Ticker.parse(response) if response
        end
        
        def market_stats(symbol, options: {})
          params      =   {symbol: symbol.to_s.upcase}
          response    =   get("/market/stats", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Ticker.new(response) if response
        end
      
      end
    end
  end
end
