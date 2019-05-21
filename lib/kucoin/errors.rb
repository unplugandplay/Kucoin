module Kucoin
  module Errors
    class Error < StandardError; end;
    class ResponseError < Kucoin::Errors::Error; end;
    class SystemError < Kucoin::Errors::Error; end;
    class ArgumentError < Kucoin::Errors::Error; end;
    
    MAPPING = {
      #https://docs.kucoin.com/#errors
      
      # HTTP error status codes
      400 => -> { raise ::Kucoin::Errors::ResponseError.new("Bad Request -- Invalid request format") },
      401 => -> { raise ::Kucoin::Errors::ResponseError.new("Unauthorized -- Invalid API Key") },
      403 => -> { raise ::Kucoin::Errors::ResponseError.new("Forbidden -- The requested data can be accessed by for administrators only.") },
      404 => -> { raise ::Kucoin::Errors::ResponseError.new("Not Found -- The specified resource could not be found.") },
      405 => -> { raise ::Kucoin::Errors::ResponseError.new("Method Not Allowed -- You tried to access the resource with an invalid method.") },
      415 => -> { raise ::Kucoin::Errors::ResponseError.new("Unsupported Media Type. You need to use: application/json.") },
      429 => -> { raise ::Kucoin::Errors::ResponseError.new("Too Many Requests -- Exceeded the access frequency limit.") },
      500 => -> { raise ::Kucoin::Errors::ResponseError.new("Internal Server Error -- We had a problem with our server. Try again later.") },
      503 => -> { raise ::Kucoin::Errors::ResponseError.new("Service Unavailable -- We're temporarily offline for maintenance. Please try again later.") },
      
      # System error codes
      400001 => -> { raise ::Kucoin::Errors::SystemError.new("Any of KC-API-KEY, KC-API-SIGN, KC-API-TIMESTAMP, KC-API-PASSPHRASE is missing in your request header") },
      400002 => -> { raise ::Kucoin::Errors::SystemError.new("KC-API-TIMESTAMP Invalid -- Your time differs from the server time by more than 5 seconds") },
      400003 => -> { raise ::Kucoin::Errors::SystemError.new("KC-API-KEY doesn’t exist") },
      400004 => -> { raise ::Kucoin::Errors::SystemError.new("KC-API-PASSPHRASE error") },
      400005 => -> { raise ::Kucoin::Errors::SystemError.new("Signature error -- Please check your signature") },
      400006 => -> { raise ::Kucoin::Errors::SystemError.new("The requested IP address is not in the API whitelist") },
      400007 => -> { raise ::Kucoin::Errors::SystemError.new("Access Denied -- Your API-key does not have sufficient permissions to access the URL") },
      404000 => -> { raise ::Kucoin::Errors::SystemError.new("Url Not Found -- The requested resource could not be found") },
      400100 => -> { raise ::Kucoin::Errors::SystemError.new("Parameter Error -- You tried to access the resource with invalid parameters") },
      411100 => -> { raise ::Kucoin::Errors::SystemError.new("User is frozen -- The user is frozen, please contact us via support center.") },
      500000 => -> { raise ::Kucoin::Errors::SystemError.new("Internal Server Error -- We had a problem with our server. Try again later.") },
    }
    
  end
end
