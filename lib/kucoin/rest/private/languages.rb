module Kucoin
  module Rest
    module Private
      module Languages
        
        def change_language(language, options: {})
          options.merge!(authenticate: true)
          parse(post("/user/change-lang", data: {lang: language}, options: options))&.fetch("success", false)
        end
      
      end
    end
  end
end
