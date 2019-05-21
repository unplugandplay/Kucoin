module Kucoin
  module Rest
    module Public
      module Trades
        
        def trades(symbol, options: {})
          params    =   {symbol: symbol.to_s.upcase}
          
          response  =   get("/market/histories", params: params, options: options)&.fetch("data", [])
          ::Kucoin::Models::Trade.parse(response) if response
        end
      
      end
    end
  end
end
