module Kucoin
  module Utilities
    class Encoding
      
      class << self
        
        def sign(string, secret: ::Kucoin.configuration.secret)
          ::OpenSSL::HMAC.hexdigest(::OpenSSL::Digest.new('sha256'), secret, ::Base64.strict_encode64(string))
        end
                  
      end
      
    end    
  end
end
