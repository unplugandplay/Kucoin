module Kucoin
  module Models
    class User < Base
      MAPPING  =   {
        oid:                        :string,
        name:                       :string,
        nickname:                   :string,
        email:                      :string,
        phone:                      :string,
        referrer_code:              :string,
        language:                   :string,
        csrf:                       :string,
        login_record:               :hash,
        base_bonus_rate:            :float,
        base_fee_rate:              :float,
        credential_status:          :string,
        currency:                   :string,
        photo_credential_validated: :boolean,
        video_validated:            :boolean,
        has_credential:             :boolean,
        phone_validated:            :boolean,
        credential_validated:       :boolean,
        google_two_fa_binding:      :boolean,
        has_trade_password:         :boolean,
        email_validated:            :boolean,
        is_china_visitor:           :boolean,
        is_suspend:                 :boolean
      }
    end
  end
end
