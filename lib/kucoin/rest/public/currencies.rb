module Kucoin
  module Rest
    module Public
      module Currencies
        
        def currencies(options: {})
          response    =   get("/currencies", options: options)&.fetch("data", [])
          ::Kucoin::Models::Currency.parse(response) if response
        end
        
        def currency(currency, chain: nil, options: {})
          params      =   chain.to_s.empty? ? nil : {chain: chain.to_s.upcase }
          response    =   get("/currencies/#{currency}", params: params, options: options)&.fetch("data", {})
          ::Kucoin::Models::Currency.new(response) if response
        end
        
        def prices(base: "USD", currencies: nil, options: {})
          params                =   {base: base.to_s.upcase}
          params[:currencies]   =   currencies.join(",") if currencies && currencies.is_a?(Array) && currencies.any?
          
          response    =   get("/prices", params: params, options: options)&.fetch("data", {})&.map { |key, value| [key, value.to_f] }.to_h
        end
      
      end
    end
  end
end
