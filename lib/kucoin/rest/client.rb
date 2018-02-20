module Kucoin
  module Rest
    class Client
      attr_accessor :url, :configuration
      
      def initialize(configuration: ::Kucoin.configuration)
        self.configuration    =   configuration
        self.url              =   "#{self.configuration.api_url}/v#{self.configuration.api_version}"
      end
      
      include ::Kucoin::Rest::Errors
      include ::Kucoin::Rest::Authentication
      
      include ::Kucoin::Rest::Public::Currencies
      include ::Kucoin::Rest::Public::Languages
      include ::Kucoin::Rest::Public::Ticker
      include ::Kucoin::Rest::Public::Orders
      include ::Kucoin::Rest::Public::Trades
      include ::Kucoin::Rest::Public::Markets
      include ::Kucoin::Rest::Public::Klines
      
      include ::Kucoin::Rest::Private::User
      include ::Kucoin::Rest::Private::Languages
      include ::Kucoin::Rest::Private::Invitations
      include ::Kucoin::Rest::Private::Transfers
      include ::Kucoin::Rest::Private::Balances
      include ::Kucoin::Rest::Private::Trading
            
      def configured?
        !self.configuration.key.to_s.empty? && !self.configuration.secret.to_s.empty?
      end

      def check_credentials!
        unless configured?
          raise ::Kucoin::Errors::MissingConfigError.new("Kucoin gem hasn't been properly configured.")
        end
      end
      
      def to_uri(path)
        "#{self.url}#{path}"
      end
      
      def signature_path(path)
        "/v#{self.configuration.api_version}#{path}"
      end
      
      def parse(response)
        error?(response)
        response
      end

      def get(path, params: {}, options: {})
        request path, method: :get, params: params, options: options
      end

      def post(path, params: {}, data: {}, options: {})
        request path, method: :post, params: params, data: data, options: options
      end

      def request(path, method: :get, params: {}, data: {}, options: {})
        should_auth   =   options.fetch(:authenticate, false)
        user_agent    =   options.fetch(:user_agent, self.configuration.faraday.fetch(:user_agent, nil))
        proxy         =   options.fetch(:proxy, nil)
    
        connection    =   Faraday.new(url: to_uri(path)) do |builder|
          builder.headers["User-Agent"]       =   user_agent if !user_agent.to_s.empty?
          builder.headers["Accept-Language"]  =   "en_EN"
          
          builder.headers.merge!(authenticate!(path, params)) if should_auth && method.eql?(:get)
          builder.headers.merge!(authenticate!(path, data))   if should_auth && method.eql?(:post)
          
          builder.request  :url_encoded if method.eql?(:post)
          builder.response :logger      if self.configuration.verbose_faraday?
          builder.response :json
      
          if proxy
            puts "[Kucoin::Rest::Client] - Will connect to Kucoin using proxy: #{proxy.inspect}" if self.configuration.verbose_faraday?
            builder.proxy = proxy
          end
      
          builder.adapter self.configuration.faraday.fetch(:adapter, :net_http)
        end
    
        case method
          when :get
            connection.get do |request|
              request.params  =   params if params && !params.empty?
            end&.body
          when :post
            connection.post do |request|
              request.body    =   data
              request.params  =   params if params && !params.empty?
            end&.body
        end
      end
            
    end
  end  
end