module Kucoin
  module Rest
    module Private
      module Accounts
        
        def sub_accounts_user_info(options: {})
          options.merge!(authenticate: true)
          response = get("/sub/user", options: options)
        end
        
        def accounts(currency: nil, type: nil, options: {})
          options.merge!(authenticate: true)
          response = get("/accounts", options: options)&.fetch("data", {})
          ::Kucoin::Models::Account.parse(response) if response
        end
        
        def account(account_id, options: {})
          options.merge!(authenticate: true)
          response = get("/accounts/#{account_id}", options: options)&.fetch("data", {})
          ::Kucoin::Models::Account.new(response) if response
        end
        
        def create_account(type: :main, currency:, options: {})
          options.merge!(authenticate: true)
          
          payload         =   {
            type:     type.to_s.downcase,
            currency: currency.to_s.upcase
          }
          
          post("/accounts", data: payload, options: options)&.dig("data", "id")
        end
        
        def account_ledger(account_id, start_at: nil, end_at: nil, options: {})
          options.merge!(authenticate: true)
          
          params              =   {}
          params[:startAt]    =   start_at.to_i unless start_at.nil?
          params[:endAt]      =   end_at.to_i unless end_at.nil?
          
          response            =   get("/accounts/#{account_id}/ledgers", params: params, options: options)&.dig("data", "items")
          ::Kucoin::Models::Ledger.parse(response) if response
        end
        
        def account_holds(account_id, options: {})
          options.merge!(authenticate: true)
          
          response            =   get("/accounts/#{account_id}/holds", options: options)&.dig("data", "items")
        end
        
        def sub_accounts(options: {})
          options.merge!(authenticate: true)
          
          response            =   get("/sub-accounts", options: options)&.fetch("data", [])
        end
        
        def sub_account_balance(sub_user_id, options: {})
          options.merge!(authenticate: true)
          
          response            =   get("/sub-accounts/#{sub_user_id}", options: options)
        end
      
      end
    end
  end
end
