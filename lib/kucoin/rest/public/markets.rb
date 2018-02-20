module Kucoin
  module Rest
    module Public
      module Markets
        
        def markets(options: {})
          parse(get("/open/markets", options: options))&.fetch("data", {})
        end
        
        # /market/open/symbols is also available, seems to be the same endpoint
        def market_symbols(market, options: {})
          response    =   parse(get("/open/symbols", params: {market: market}, options: options))&.fetch("data", {})
          ::Kucoin::Models::Ticker.parse(response) if response
        end
        
        def trending_symbols(market, options: {})
          response    =   parse(get("/market/open/coins-trending", params: {market: market}, options: options))&.fetch("data", {})
        end
        
        def coins(options: {})
          response    =   parse(get("/market/open/coins", options: options))&.fetch("data", {})
          ::Kucoin::Models::Coin.parse(response) if response
        end
        
        def coin_info(coin, options: {})
          response    =   parse(get("/market/open/coin-info", params: {coin: coin}, options: options))&.fetch("data", {})
          ::Kucoin::Models::Coin.new(response) if response
        end
      
      end
    end
  end
end
