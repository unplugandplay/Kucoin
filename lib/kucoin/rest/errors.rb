module Kucoin
  module Rest
    module Errors
      
      def error?(response)
        if response.is_a?(Hash) && (response.has_key?("code") || response.has_key?("msg")) 
          code        =   response.fetch("code", nil)&.to_i
          message     =   response.fetch("msg", nil)
          
          if code
            ::Kucoin::Errors::MAPPING.fetch(code, nil)&.call
          else
            raise ::Kucoin::Errors::ResponseError.new(message)
          end
        end
      end
            
    end
  end  
end
