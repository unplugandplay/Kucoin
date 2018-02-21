module Kucoin
  module Rest
    module Public
      module Klines
        
        # Not working propely / not implemented?
        def kline_data(symbol, type: :one_hour, from: nil, to: nil, limit: 100, options: {})
          to      ||=   Time.now.utc
          from    ||=   default_from_time(type, to)
          from      =   from.to_i unless from.is_a?(Integer)
          to        =   to.to_i   unless to.is_a?(Integer)
          
          type      =   ::Kucoin::Constants::STANDARD_KLINE_RESOLUTIONS[type]
          
          params    =   {
            symbol: symbol,
            type:   type,
            from:   from,
            to:     to,
            limit:  limit
          }
          
          params.delete_if { |key, value| value.nil? }
          
          response  = get("/open/kline", params: params, options: options)&.fetch("data", {})
        end
        
        #
        # TradingView related endpoints: 
        # 
        def kline_config(options: {})
          get("/open/chart/config", options: options)
        end
        
        def chart_symbol(symbol, options: {})
          response    =   get("/open/chart/symbols", params: {symbol: symbol}, options: options)
        end
        
        def chart_kline_data(symbol, resolution: :one_hour, from: nil, to: nil, options: {})
          to        ||=   Time.now.utc
          from      ||=   default_from_time(resolution, to)
          from        =   from.to_i unless from.is_a?(Integer)
          to          =   to.to_i   unless to.is_a?(Integer)
          
          resolution  =   ::Kucoin::Constants::TRADING_VIEW_KLINE_RESOLUTIONS[resolution]
          
          params    =   {
            symbol:       symbol,
            resolution:   resolution,
            from:         from,
            to:           to
          }
          
          params.delete_if { |key, value| value.nil? }
          
          response    =   get("/open/chart/history", params: params, options: options)
          ::Kucoin::Models::OHLCV.parse(response) if response
        end
        
        private
          def default_from_time(type, time = Time.now.utc)
            case type
              when :one_minute
                time - (1 * ::Kucoin::Constants::IN_SECONDS[:minute])
              when :five_minutes
                time - (5 * ::Kucoin::Constants::IN_SECONDS[:minute])
              when :fifteen_minutes
                time - (15 * ::Kucoin::Constants::IN_SECONDS[:minute])
              when :thirty_minutes
                time - (30 * ::Kucoin::Constants::IN_SECONDS[:minute])
              when :one_hour
                time - (1 * ::Kucoin::Constants::IN_SECONDS[:hour])
              when :eight_hours
                time - (8 * ::Kucoin::Constants::IN_SECONDS[:hour])
              when :one_day
                time - (1 * ::Kucoin::Constants::IN_SECONDS[:day])
              when :one_week
                time - (1 * ::Kucoin::Constants::IN_SECONDS[:week])
            end
          end
      
      end
    end
  end
end
