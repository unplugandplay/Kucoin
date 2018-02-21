module Kucoin
  module Rest
    module Public
      module Markets
        
        def markets(options: {})
          get("/open/markets", options: options)&.fetch("data", {})
        end
        
        def market_symbols(market: nil, options: {})
          params      =   {
            market: market.to_s.upcase,
          }
          
          params.delete_if { |key, value| value.nil? || value.to_s.empty? }
          
          response    =   get("/market/open/symbols", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Ticker.parse(response) if response
        end
        
        def trending_symbols(market: nil, options: {})
          params      =   {
            market: market.to_s.upcase,
          }
          
          params.delete_if { |key, value| value.nil? || value.to_s.empty? }
          
          response    =   get("/market/open/coins-trending", params: params, options: options)&.fetch("data", {})
        end
        
        def coins(options: {})
          response    =   get("/market/open/coins", options: options)&.fetch("data", {})
          ::Kucoin::Models::Coin.parse(response) if response
        end
        
        def coin_info(coin, options: {})
          response    =   get("/market/open/coin-info", params: {coin: coin}, options: options)&.fetch("data", {})
          ::Kucoin::Models::Coin.new(response) if response
        end
      
      end
    end
  end
end
