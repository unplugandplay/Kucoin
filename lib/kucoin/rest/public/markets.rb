module Kucoin
  module Rest
    module Public
      module Markets
        
        def symbols(market = nil, options: {})
          params      =   market.to_s.empty? ? {} : {market: market.to_s.upcase}
          
          response    =   get("/symbols", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Symbol.parse(response) if response
        end
        
        def markets(options: {})
          get("/markets", options: options)&.fetch("data", {})
        end
      
      end
    end
  end
end
