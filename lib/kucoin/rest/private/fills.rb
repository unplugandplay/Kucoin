module Kucoin
  module Rest
    module Private
      module Fills
        
        def fills(order_id: nil, symbol: nil, side: nil, type: nil, start_at: nil, end_at: nil, options: {})
          options.merge!(authenticate: true)
          
          params            =   {}
          params[:orderId]  =   order_id.to_s unless order_id.to_s.empty?
          params[:symbol]   =   symbol.to_s.upcase unless symbol.to_s.empty?
          params[:side]     =   side.to_s.downcase unless side.to_s.empty?
          params[:type]     =   type.to_s.downcase unless type.to_s.empty?
          params[:startAt]  =   start_at.to_i unless start_at.nil?
          params[:endAt]    =   end_at.to_i unless end_at.nil?
          
          response    =   get("/fills", params: params, options: options)&.dig("data", "items")
          ::Kucoin::Models::Fill.parse(response) if response
        end
        
        def recent_fills(options: {})
          options.merge!(authenticate: true)
          
          response    =   get("/limit/fills", options: options)&.fetch("data", [])
          ::Kucoin::Models::Fill.parse(response) if response
        end
      
      end
    end
  end
end
