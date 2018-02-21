module Kucoin
  module Rest
    module Private
      module User
        
        def user_info(options: {})
          options.merge!(authenticate: true)
          response = get("/user/info", options: options)&.fetch("data", {})
          ::Kucoin::Models::User.new(response) if response
        end
      
      end
    end
  end
end
