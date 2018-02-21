module Kucoin
  module Rest
    module Private
      module Markets
        
        # Market: BTC, ETH, etc.
        # Symbol: HPB-ETH, ITC-ETH etc.
        # Filter: FAVOURITE / STICK
        
        def user_market_symbols(market: nil, symbol: nil, filter: nil, options: {})
          options.merge!(authenticate: true)
          
          params      =   {
            market: market.to_s.upcase,
            symbol: symbol.to_s.upcase,
            filter: filter.to_s.upcase
          }
          
          params.delete_if { |key, value| value.nil? || value.to_s.empty? }
          
          response    =   get("/market/symbols", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Ticker.parse(response) if response
        end
        
        def stick_symbols(options: {})
          options.merge!(authenticate: true)
          response    =   get("/market/stick-symbols", params: {}, options: options)&.fetch("data", {})
        end
        
        def favorite_symbols(options: {})
          options.merge!(authenticate: true)
          response    =   get("/market/fav-symbols", params: {}, options: options)&.fetch("data", {})
        end
      
      end
    end
  end
end
