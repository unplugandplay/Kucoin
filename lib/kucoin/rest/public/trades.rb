module Kucoin
  module Rest
    module Public
      module Trades
        
        def trades(symbol, limit: 100, since: nil, options: {})
          params    =   {
            symbol: symbol,
            limit:  limit,
            since:  since
          }
          
          params.delete_if { |key, value| value.nil? }
          
          response  = get("/open/deal-orders", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Trade.parse(response) if response
        end
      
      end
    end
  end
end
