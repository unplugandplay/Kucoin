module Kucoin
  module Rest
    module Errors
      
      def error?(response)
        if response.is_a?(Hash) && (response.has_key?("error") || response.has_key?("code")) 
          status      =   nil
          message     =   nil
          
          if response.has_key?("error")
            error     =   response.fetch("error", nil)
            status    =   response.fetch("status", nil)
            message   =   response.fetch("message", nil)
          elsif response.has_key?("code") && response.fetch("code", nil).eql?("ERROR")
            message   =   response.fetch("msg", nil)
          end
          
          if !message.to_s.empty?
            if status.nil?
              raise ::Kucoin::Errors::ResponseError.new(message)
            else
              ::Kucoin::Errors::MAPPING.fetch(status, nil)&.call
            end
          end
        end
      end
            
    end
  end  
end
