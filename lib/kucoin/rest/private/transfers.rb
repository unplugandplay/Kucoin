module Kucoin
  module Rest
    module Private
      module Transfers
        
        def get_coin_address(coin, options: {})
          options.merge!(authenticate: true)
          response = parse(get("/account/#{coin}/wallet/address", options: options))&.fetch("data", {})
          ::Kucoin::Models::CoinAddress.new(response) if response
        end
        
        def create_withdrawal(coin, amount:, address:, options: {})
          options.merge!(authenticate: true)
          parse(post("/account/#{coin}/withdraw/apply", data: {coin: coin, amount: amount, address: address}, options: options))
        end
        
        def cancel_withdrawal(coin, transaction_id:, options: {})
          options.merge!(authenticate: true)
          parse(post("/account/#{coin}/withdraw/cancel", data: {txOid: transaction_id}, options: options))
        end
      
      end
    end
  end
end
