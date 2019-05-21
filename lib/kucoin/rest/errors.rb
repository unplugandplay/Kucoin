module Kucoin
  module Rest
    module Errors
      
      def error?(response)
        if response.is_a?(Hash) && response.has_key?("code") && response.has_key?("msg") && !response.has_key?("data")
          code        =   response.fetch("code", nil)
          message     =   response.fetch("msg", nil)
          callback    =   !code.to_s.empty? ? ::Kucoin::Errors::MAPPING.fetch(code&.to_i, nil) : nil
          
          if callback
            callback.call(message)
          else
            raise ::Kucoin::Errors::ResponseError.new(message)
          end
        end
      end
            
    end
  end  
end
