module Kucoin
  module Utilities
    class Encoding
      
      class << self
        
        def sign(message, secret: ::Kucoin.configuration.secret)
          ::Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), secret, message)).strip
        end
                  
      end
      
    end    
  end
end
