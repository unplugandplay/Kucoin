module Kucoin
  module Rest
    class Client
      attr_accessor :url, :configuration
      
      def initialize(configuration: ::Kucoin.configuration)
        self.configuration    =   configuration
        self.url              =   "#{self.configuration.api_url}/api/v#{self.configuration.api_version}"
      end
      
      include ::Kucoin::Rest::Errors
      include ::Kucoin::Rest::Authentication
      
      include ::Kucoin::Rest::Public::Currencies
      include ::Kucoin::Rest::Public::Orders
      include ::Kucoin::Rest::Public::Trades
      include ::Kucoin::Rest::Public::Markets
      include ::Kucoin::Rest::Public::Tickers
      include ::Kucoin::Rest::Public::Klines
      
      include ::Kucoin::Rest::Private::Transfers
      include ::Kucoin::Rest::Private::Accounts
      include ::Kucoin::Rest::Private::Orders
      include ::Kucoin::Rest::Private::Fills
            
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
        "/api/v#{self.configuration.api_version}#{path}"
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
      
      def delete(path, params: {}, data: {}, options: {})
        request path, method: :delete, params: params, data: data, options: options
      end

      def request(path, method: :get, params: {}, data: {}, options: {})
        should_auth   =   options.fetch(:authenticate, false)
        user_agent    =   options.fetch(:user_agent, self.configuration.faraday.fetch(:user_agent, nil))
        proxy         =   options.fetch(:proxy, nil)
    
        connection    =   Faraday.new(url: to_uri(path)) do |builder|
          builder.headers["User-Agent"]       =   user_agent if !user_agent.to_s.empty?
          
          builder.headers.merge!(authenticate!(method, path, params: params))             if should_auth && method.eql?(:get)
          builder.headers.merge!(authenticate!(method, path, params: params, data: data)) if should_auth && ::Kucoin::Constants::HTTP_DATA_VERBS.include?(method)
          
          builder.request  :json   if ::Kucoin::Constants::HTTP_DATA_VERBS.include?(method)
          builder.response :logger if self.configuration.verbose_faraday?
          builder.response :json
      
          if proxy
            puts "[Kucoin::Rest::Client] - Will connect to Kucoin using proxy: #{proxy.inspect}" if self.configuration.verbose_faraday?
            builder.proxy = proxy
          end
      
          builder.adapter self.configuration.faraday.fetch(:adapter, :net_http)
        end
    
        response = case method
          when :get
            connection.get do |request|
              request.params      =   params if params && !params.empty?
            end&.body
          when *::Kucoin::Constants::HTTP_DATA_VERBS
            connection.send(method) do |request|
              request.body        =   data   if data && !data.empty?
              request.params      =   params if params && !params.empty?
            end&.body
        end
        
        parse(response)
      end
            
    end
  end  
end
