module Kucoin
  module Rest
    module Private
      module Trading
                
        def create_buy_order(symbol, price:, amount:, options: {})
          create_order(symbol, type: :buy, price: price, amount: amount, options: options)
        end
        
        def create_sell_order(symbol, price:, amount:, options: {})
          create_order(symbol, type: :sell, price: price, amount: amount, options: options)
        end
        
        def create_order(symbol, type: :buy, price:, amount:, options: {})
          options.merge!(authenticate: true)

          payload   =   {
            symbol: symbol.to_s.upcase,
            type:   type.to_s.upcase,
            price:  price,
            amount: amount
          }
          
          response  =   post("/order", data: payload, options: options)

          return {success: response&.fetch("success", false), id: response&.dig("data", "orderOid")}
        end
        
        def cancel_order(symbol, type: :buy, order_id:, options: {})
          options.merge!(authenticate: true)
          
          payload   =     {
            orderOid: order_id,
            type:     type.to_s.upcase
          }
          
          post("/#{symbol}/cancel-order", data: payload, options: options)&.fetch("success", false)
        end
        
        def cancel_all_orders(symbol, type: nil, options: {})
          options.merge!(authenticate: true)
          
          payload   =     {
            symbol:   symbol.to_s.upcase,
            type:     type.to_s.upcase
          }
          
          payload.delete_if { |key, value| value.nil? || value.to_s.empty? }
          
          post("/order/cancel-all", data: payload, options: options)&.fetch("success", false)
        end
        
        def active_orders(symbol, type: :buy, options: {})
          options.merge!(authenticate: true)
          
          params    =   {
            symbol: symbol.to_s.upcase,
            type:   type.to_s.upcase
          }
          
          response  =   get("/order/active", params: params, options: options)&.fetch("data", [])
          ::Kucoin::Models::Order.parse(response) if response
        end
        
        def active_orders_map(symbol, type: :buy, options: {})
          options.merge!(authenticate: true)
          
          params    =   {
            symbol: symbol.to_s.upcase,
            type:   type.to_s.upcase
          }
          
          response  =   get("/order/active-map", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Order.parse_map(response) if response
        end
        
        def dealt_orders(symbol, type: nil, before: nil, since: nil, limit: nil, page: nil, options: {})
          options.merge!(authenticate: true)
          
          params    =   {
            symbol: symbol.to_s.upcase,
            type:   type.to_s.upcase,
            before: before,
            since:  since,
            limit:  limit,
            page:   page
          }
          
          params.delete_if { |key, value| value.nil? }
          
          response  =   get("/order/dealt", params: params, options: options)&.dig("data", "datas")
          ::Kucoin::Models::Deal.parse(response) if response
        end
        
        def symbol_dealt_orders(symbol, type: nil, limit: nil, page: nil, options: {})
          options.merge!(authenticate: true)
          
          params    =   {
            symbol: symbol.to_s.upcase,
            type:   type.to_s.upcase,
            limit:  limit,
            page:   page
          }
          
          params.delete_if { |key, value| value.nil? }
          
          response  =   get("/deal-orders", params: params, options: options)&.dig("data", "datas")
          ::Kucoin::Models::Deal.parse(response) if response
        end
        
        def order_detail(symbol, order_id:, type: :buy, limit: nil, page: nil, options: {})
          options.merge!(authenticate: true)
          
          params    =   {
            symbol:     symbol.to_s.upcase,
            orderOid:   order_id,
            type:       type.to_s.upcase,
            limit:      limit,
            page:       page
          }
          
          params.delete_if { |key, value| value.nil? }
          
          response  =   get("/order/detail", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Order.new(response) if response
        end
      
      end
    end
  end
end
