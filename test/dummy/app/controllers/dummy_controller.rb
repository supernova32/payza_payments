class DummyController < ApplicationController
  def index
    @payza = PayzaPayments::ButtonGenerator.new PAYZA_CONFIG
  end

  def ipn_notification
    @payza = PayzaPayments::IpnHandler.new PAYZA_CONFIG
    @response = @payza.handle_ipn_v2(params[:token])
    p @response.inspect
    render nothing: true
  end
end