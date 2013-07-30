require 'httparty'
module PayzaPayments
  class IpnHandler < Base

    SANDBOX_IPN = 'https://sandbox.payza.com/sandbox/ipn2.ashx'
    PRODUCTION_IPN = 'https://secure.payza.com/ipn2.ashx'

    def initialize(attributes = {})
      super
    end

    def handle_ipn(params)
      if params[:ap_securitycode] == self.ipn_security_code and params[:ap_merchant] == self.merchant_email
        true
      else
        false
      end
    end

    def handle_ipn_v2(token)
      validate_ipn(token) ? @response.parsed_response : 'INVALID REQUEST'
    end

    private

    def validate_ipn(token)
      if PayzaPayments.sandbox?
        send_ipn_validation(token, SANDBOX_IPN)
      else
        send_ipn_validation(token, PRODUCTION_IPN)
      end
    end

    def send_ipn_validation(token_value, url)
      token = { token: token_value }
      @response = HTTParty.post(url, token)
      if @response.parsed_response == 'INVALID TOKEN'
        false
      else
        true
      end
    end
  end
end
