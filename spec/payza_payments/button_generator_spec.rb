require 'spec_helper'
require 'action_view'

class ButtonTest < ActionView::TestCase

end

describe PayzaPayments::ButtonGenerator do
  let :attributes do
    {ipn_security_code: 'U123456', merchant_email: 'support@freedomvpn.info', sandbox: true}
  end

  let :instance do
    PayzaPayments::ButtonGenerator.new attributes
  end

  describe '.generate_simple_button' do

    it 'should render a valid button' do
      instance.generate_simple_button(ButtonTest.new, :item, 'test', 5, 'EUR', 'https://freedomvpn.info',
      'https://freedomvpn.info', 'test', 1).should == '<form action="https://secure.payza.com/checkout" method="post"><input name="ap_purchasetype" type="hidden" value="item" /><input name="ap_merchant" type="hidden" value="support@freedomvpn.info" /><input name="ap_itemname" type="hidden" value="test" /><input name="ap_currency" type="hidden" value="EUR" /><input name="ap_amount" type="hidden" value="5" /><input name="ap_description" type="hidden" value="test" /><input name="ap_returnurl" type="hidden" value="https://freedomvpn.info" /><input name="ap_cancelurl" type="hidden" value="https://freedomvpn.info" /><input name="apc_1" type="hidden" value="1" /><input name="ap_image" src="https://www.payza.com/images/payza-buy-now.png" type="image" /><input name="ap_timeunit" type="hidden" value="Month" /><input name="ap_periodlength" type="hidden" value="12" /></form>'
    end
  end
end