module Kucoin
  module Rest
    module Private
      module Invitations
        
        def invitation_count(options: {})
          options.merge!(authenticate: true)
          get("/referrer/descendant/count", options: options)&.fetch("data", {})
        end
        
        def promotion_reward(options: {})
          options.merge!(authenticate: true)
          get("/account/promotion/info", options: options)&.fetch("data", {})
        end
        
        def promotion_summary(options: {})
          options.merge!(authenticate: true)
          get("/account/promotion/sum", options: options)&.fetch("data", {})
        end
      
      end
    end
  end
end
