module Kucoin
  module Constants
    
    IN_SECONDS = {
      minute: 60,
      hour:   3600,
      day:    86400,
      week:   604800
    }
    
    STANDARD_KLINE_RESOLUTIONS = {
      one_minute:      "1min",
      five_minutes:    "5min",
      fifteen_minutes: "15min",
      thirty_minutes:  "30min",
      one_hour:        "1hour",
      eight_hours:     "8hour",
      one_day:         "1day",
      one_week:        "1week" 
    }
    
    TRADING_VIEW_KLINE_RESOLUTIONS = {
      one_minute:      "1",
      five_minutes:    "5",
      fifteen_minutes: "15",
      thirty_minutes:  "30",
      one_hour:        "60",
      eight_hours:     "480",
      one_day:         "D",
      one_week:        "W"
    }
    
  end
end
