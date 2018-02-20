module Kucoin
  module Rest
    module Authentication
      
      def authenticate!(path, params)
        data              =   sign_message(path, params)
        
        {
          'KC-API-KEY'        =>  self.configuration.key,
          'KC-API-NONCE'      =>  data[:nonce],
          'KC-API-SIGNATURE'  =>  data[:signature],
        }
      end
      
      def nonce
        (Time.now.to_f * 1000).to_i.to_s
      end
      
      def sign_message(path, params = nil)
        path              =   signature_path(path)
        nonced            =   nonce
        params            =   compose_params(params)
        message           =   "#{path}/#{nonced}/#{params}"
        signature         =   ::Kucoin::Utilities::Encoding.sign(message, secret: self.configuration.secret)
        
        return {nonce: nonced, signature: signature}
      end
      
      def compose_params(params)
        return params unless params.is_a? Hash
        uri               =   Addressable::URI.new
        uri.query_values  =   params
        uri.query
      end
            
    end
  end  
end
