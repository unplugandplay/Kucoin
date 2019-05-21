module Kucoin
  module Rest
    module Private
      module Orders
        
        def create_buy_order(symbol,
          order_id: nil,
          price: nil,
          size: nil,
          type: :limit,
          time_in_force: :gtc,
          cancel_after: nil,
          post_only: nil,
          hidden: nil,
          iceberg: nil,
          iceberg_visible_size: nil,
          remark: nil,
          stop: nil,
          stop_price: nil,
          self_trade_prevention: nil,
          funds: nil,
          options: {}
        )
          create_order(symbol,
            order_id: order_id,
            side: :buy,
            price: price,
            size: size,
            type: type,
            time_in_force: time_in_force,
            cancel_after: cancel_after,
            post_only: post_only,
            hidden: hidden,
            iceberg: iceberg,
            iceberg_visible_size: iceberg_visible_size,
            remark: remark,
            stop: stop,
            stop_price: stop_price,
            self_trade_prevention: self_trade_prevention,
            funds: funds,
            options: options
          )
        end
        
        def create_sell_order(symbol,
          order_id: nil,
          price: nil,
          size: nil,
          type: :limit,
          time_in_force: :gtc,
          cancel_after: nil,
          post_only: nil,
          hidden: nil,
          iceberg: nil,
          iceberg_visible_size: nil,
          remark: nil,
          stop: nil,
          stop_price: nil,
          self_trade_prevention: nil,
          funds: nil,
          options: {}
        )
          
          create_order(symbol,
            order_id: order_id,
            side: :sell,
            price: price,
            size: size,
            type: type,
            time_in_force: time_in_force,
            cancel_after: cancel_after,
            post_only: post_only,
            hidden: hidden,
            iceberg: iceberg,
            iceberg_visible_size: iceberg_visible_size,
            remark: remark,
            stop: stop,
            stop_price: stop_price,
            self_trade_prevention: self_trade_prevention,
            funds: funds,
            options: options
          )
        end
        
        def create_order(symbol,
          order_id: nil,
          side: :buy,
          price: nil,
          size: nil,
          type: :limit,
          time_in_force: :gtc,
          cancel_after: nil,
          post_only: nil,
          hidden: nil,
          iceberg: nil,
          iceberg_visible_size: nil,
          remark: nil,
          stop: nil,
          stop_price: nil,
          self_trade_prevention: nil,
          funds: nil,
          options: {}
        )
          options.merge!(authenticate: true)
          
          order_id      ||=   SecureRandom.uuid

          payload         =   {
            clientOid: order_id,
            side:      side.to_s.downcase,
            symbol:    symbol.to_s.upcase,
            type:      type.to_s.downcase
          }
          
          payload[:remark]          =   remark unless remark.to_s.empty?
          
          if stop && stop_price
            payload[:stop]          =   stop.to_s
            payload[:stopPrice]     =   stop_price.to_s
          end
          
          payload[:stp]             =   self_trade_prevention unless self_trade_prevention.to_s.empty?
          
          if payload[:type] == "limit"
            raise ::Kucoin::Errors::ArgumentError.new("You need to specify a price for limit orders!") if price.to_s.empty?
            raise ::Kucoin::Errors::ArgumentError.new("You need to specify a quantity/size for limit orders!") if size.to_s.empty?
            
            payload[:price]         =   price.to_s
            payload[:size]          =   size.to_s
            
            payload[:timeInForce]   =   time_in_force.to_s.upcase unless time_in_force.to_s.empty?
            payload[:cancelAfter]   =   cancel_after.to_i unless cancel_after.to_s.empty?
            payload[:postOnly]      =   post_only unless post_only.nil?
            payload[:hidden]        =   hidden unless hidden.nil?
            payload[:iceberg]       =   iceberg unless iceberg.nil?
            payload[:visibleSize]   =   iceberg_visible_size.to_s unless iceberg_visible_size.to_s.empty?
            
          elsif payload[:type] == "market"
            raise ::Kucoin::Errors::ArgumentError.new("You need to either specify a size of the base currency or the quote currency") if size.to_s.empty? && funds.to_s.empty?
            raise ::Kucoin::Errors::ArgumentError.new("You can can't create orders with both size and funds specified, please choose one of the two.") if !size.to_s.empty? && !funds.to_s.empty?
            
            payload[:size]          =   size.to_s unless size.to_s.empty?
            payload[:funds]         =   funds.to_s unless funds.to_s.empty?
          end
          
          order_id                  =   post("/orders", data: payload, options: options)&.dig("data", "orderId")
          
          return order_id
        end
        
        def cancel_order(order_id, options: {})
          options.merge!(authenticate: true)
          
          payload   =     {
            orderId: order_id
          }
          
          response  =   delete("/orders/#{order_id}", options: options)&.dig("data", "cancelledOrderIds")
        end
        
        def cancel_all_orders(symbol = nil, options: {})
          options.merge!(authenticate: true)
          
          params      =   !symbol.to_s.empty? ? {symbol: symbol.to_s.upcase} : nil
          
          response    =   delete("/orders", params: params, options: options)&.dig("data", "cancelledOrderIds")
        end
        
        def active_orders(symbol: nil, side: nil, type: nil, start_at: nil, end_at: nil, options: {})
          orders(symbol: symbol, status: :active, side: side, type: type, start_at: start_at, end_at: end_at, options: options)
        end
        
        def completed_orders(symbol: nil, side: nil, type: nil, start_at: nil, end_at: nil, options: {})
          orders(symbol: symbol, status: :done, side: side, type: type, start_at: start_at, end_at: end_at, options: options)
        end
        
        def orders(symbol: nil, status: :done, side: nil, type: nil, start_at: nil, end_at: nil, options: {})
          options.merge!(authenticate: true)
          
          params      =   {
            status: status
          }
          
          params[:symbol]   =   symbol.to_s.upcase unless symbol.to_s.empty?
          params[:side]     =   side.to_s.downcase unless side.to_s.empty?
          params[:type]     =   type.to_s.downcase unless type.to_s.empty?
          params[:startAt]  =   start_at.to_i unless start_at.nil?
          params[:endAt]    =   end_at.to_i unless end_at.nil?
          
          response    =   get("/orders", params: params, options: options)&.dig("data", "items")
          ::Kucoin::Models::Order.parse(response) if response
        end
        
        def recent_orders(options: {})
          options.merge!(authenticate: true)
          
          response    =   get("/limit/orders", options: options)&.fetch("data", [])
          ::Kucoin::Models::Order.parse(response) if response
        end
        
        def order(order_id, options: {})
          options.merge!(authenticate: true)
          
          response    =   get("/orders/#{order_id}", options: options)&.fetch("data", {})
          ::Kucoin::Models::Order.new(response) if response
        end
      
      end
    end
  end
end
