module Kucoin
  module Rest
    module Public
      module Languages
        
        def languages(options: {})
          parse(get("/open/lang-list", options: options))&.fetch("data", [])
        end
      
      end
    end
  end
end
