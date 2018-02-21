module Kucoin
  module Rest
    module Public
      module Languages
        
        def languages(options: {})
          get("/open/lang-list", options: options)&.fetch("data", [])
        end
      
      end
    end
  end
end
