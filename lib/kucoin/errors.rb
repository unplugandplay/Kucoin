module Kucoin
  module Errors
    class Error < StandardError; end;
    class ResponseError < Kucoin::Errors::Error; end;
    class SystemError < Kucoin::Errors::Error; end;
    class ArgumentError < Kucoin::Errors::Error; end;
    
    MAPPING = {
      #https://docs.kucoin.com/#errors
      
      # HTTP error status codes
      400 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Bad Request -- Invalid request format") },
      401 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Unauthorized -- Invalid API Key") },
      403 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Forbidden -- The requested data can be accessed by for administrators only.") },
      404 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Not Found -- The specified resource could not be found.") },
      405 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Method Not Allowed -- You tried to access the resource with an invalid method.") },
      415 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Unsupported Media Type. You need to use: application/json.") },
      429 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Too Many Requests -- Exceeded the access frequency limit.") },
      500 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Internal Server Error -- We had a problem with our server. Try again later.") },
      503 => -> (message = nil) { raise ::Kucoin::Errors::ResponseError.new(message || "Service Unavailable -- We're temporarily offline for maintenance. Please try again later.") },
      
      # System error codes
      400001 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "Any of KC-API-KEY, KC-API-SIGN, KC-API-TIMESTAMP, KC-API-PASSPHRASE is missing in your request header") },
      400002 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "KC-API-TIMESTAMP Invalid -- Your time differs from the server time by more than 5 seconds") },
      400003 => -> (message = nil){ raise ::Kucoin::Errors::SystemError.new(message || "KC-API-KEY doesn’t exist") },
      400004 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "KC-API-PASSPHRASE error") },
      400005 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "Signature error -- Please check your signature") },
      400006 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "The requested IP address is not in the API whitelist") },
      400007 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "Access Denied -- Your API-key does not have sufficient permissions to access the URL") },
      404000 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "Url Not Found -- The requested resource could not be found") },
      400100 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "Parameter Error -- You tried to access the resource with invalid parameters") },
      411100 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "User is frozen -- The user is frozen, please contact us via support center.") },
      500000 => -> (message = nil) { raise ::Kucoin::Errors::SystemError.new(message || "Internal Server Error -- We had a problem with our server. Try again later.") },
    }
    
  end
end
