module Kucoin
  module Rest
    module Public
      module Orders
        
        def orders(symbol, limit: 100, group: nil, options: {})
          get_orders(symbol: symbol, endpoint: "/open/orders", params: order_params(symbol, group, limit), type: nil, options: options)
        end
        
        def buy_orders(symbol, limit: 100, group: nil, options: {})
          get_orders(symbol: symbol, endpoint: "/open/orders-buy", params: order_params(symbol, group, limit), type: "BUY", options: options)
        end
        
        def sell_orders(symbol, limit: 100, group: nil, options: {})
          get_orders(symbol: symbol, endpoint: "/open/orders-sell", params: order_params(symbol, group, limit), type: "SELL", options: options)
        end
        
        private
          def get_orders(symbol:, endpoint:, params: {}, type: nil, options: {})
            response = get(endpoint, params: params, options: options)&.merge("symbol" => symbol)
            ::Kucoin::Models::OrderBook.new(response, type: type) if response
          end
          
          def order_params(symbol, group = nil, limit = nil)
            params          =   {
              symbol: symbol,
              group:  group,
              limit:  limit
            }
            
            params.delete_if { |key, value| value.nil? }
          
            return params
          end
      
      end
    end
  end
end
