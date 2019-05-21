module Kucoin
  module Rest
    module Public
      module Orders
        
        def partial_order_book(symbol, depth: 20, options: {})
          order_book(symbol, level: 2, depth: depth, options: options)
        end
        
        def full_aggregated_order_book(symbol, options: {})
          order_book(symbol, level: 2, depth: nil, options: options)
        end
        
        def full_atomic_order_book(symbol, options: {})
          order_book(symbol, level: 3, depth: nil, options: options)
        end
        
        def order_book(symbol, level: 2, depth: nil, options: {})
          params      =   {symbol: symbol.to_s.upcase}
          path        =   depth.nil? ? "/market/orderbook/level#{level}" : "/market/orderbook/level#{level}_#{depth}"
          response    =   get(path, params: params, options: options)&.fetch("data", {})
        end
      
      end
    end
  end
end
