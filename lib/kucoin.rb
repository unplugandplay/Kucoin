# Rest API
require "faraday"
require "faraday_middleware"

# Shared
require "openssl"
require "base64"
require "addressable/uri"
require "json"
require "date"
require "securerandom"

require "kucoin/version"

require "kucoin/configuration"
require "kucoin/errors"
require "kucoin/constants"

require "kucoin/utilities/parsing"
require "kucoin/utilities/encoding"

require "kucoin/models/base"
require "kucoin/models/ticker"
require "kucoin/models/trade"
require "kucoin/models/account"
require "kucoin/models/ledger"
require "kucoin/models/symbol"
require "kucoin/models/currency"
require "kucoin/models/order"
require "kucoin/models/fill"

require "kucoin/rest/public/currencies"
require "kucoin/rest/public/tickers"
require "kucoin/rest/public/orders"
require "kucoin/rest/public/trades"
require "kucoin/rest/public/markets"
require "kucoin/rest/public/klines"

require "kucoin/rest/private/transfers"
require "kucoin/rest/private/accounts"
require "kucoin/rest/private/orders"
require "kucoin/rest/private/fills"

require "kucoin/rest/errors"
require "kucoin/rest/authentication"
require "kucoin/rest/client"

if !String.instance_methods(false).include?(:underscore)
  require "kucoin/extensions/string"
end

if !Hash.instance_methods(false).include?(:symbolize_keys)
  require "kucoin/extensions/hash"
end

module Kucoin
  
  class << self
    attr_writer :configuration
  end
  
  def self.configuration
    @configuration ||= ::Kucoin::Configuration.new
  end

  def self.reset
    @configuration = ::Kucoin::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
  
end
