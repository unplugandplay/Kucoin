module Kucoin
  module Rest
    module Public
      module Klines
        
        # Note that start_at and end_at should be in seconds and not millisecond this time around 
        def klines(symbol, type: "1hour", start_at: nil, end_at: nil, options: {})
          params    =   {
            symbol: symbol.to_s.upcase,
            type:   type
          }
          
          params[:startAt]  =   start_at.to_i unless start_at.nil?
          params[:endAt]    =   end_at.to_i   unless end_at.nil?
          
          response  =   get("/market/candles", params: params, options: options)&.fetch("data", [])
        end
      
      end
    end
  end
end
