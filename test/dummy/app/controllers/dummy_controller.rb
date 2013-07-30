class DummyController < ApplicationController
  def index
    @payza = PayzaPayments::ButtonGenerator.new PAYZA_CONFIG
  end
end