module Kucoin
  module Errors
    class Error < StandardError; end;
    class ResponseError < Kucoin::Errors::Error; end;
    
    MAPPING = {
      404 => -> { raise ::Kucoin::Errors::ResponseError.new("Endpoint couldn't be found. Make sure the endpoint you're calling is a supported KuCoin API Endpoint.") },
    }
    
  end
end
