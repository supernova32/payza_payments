#require 'action_view'
module PayzaPayments
  class ButtonGenerator < Base
    include ActionView::Helpers

    def initialize(attributes = {})
      super
    end

    def generate_simple_button(action, purchase_type, item_name, amount, currency, return_url, cancel_url, item_description, order_id)
      action.content_tag(:form, method: :post, action: 'https://secure.payza.com/checkout') do
        common_tags(purchase_type, item_name, amount, currency, return_url, cancel_url, item_description, order_id)
      end
    end

    def generate_subscription_button(action, purchase_type, item_name, amount, currency, return_url, cancel_url,
                                     item_description, order_id, time_unit, period_length)
      action.content_tag :form, method: :post, action: 'https://secure.payza.com/checkout' do
        common_tags(purchase_type, item_name, amount, currency, return_url, cancel_url, item_description, order_id) +
        tag(:input, type: :hidden, name: 'ap_timeunit', value: time_unit) +
        tag(:input, type: :hidden, name: 'ap_periodlength', value: period_length)
      end
    end

    private

    def common_tags(purchase_type, item_name, amount, currency, return_url, cancel_url, item_description, order_id)
      tag(:input, type: :hidden, name: 'ap_purchasetype', value: purchase_type) +
      tag(:input, type: :hidden, name: 'ap_merchant', value: self.merchant_email) +
      tag(:input, type: :hidden, name: 'ap_itemname', value: item_name) +
      tag(:input, type: :hidden, name: 'ap_currency', value: currency) +
      tag(:input, type: :hidden, name: 'ap_amount', value: amount) +
      tag(:input, type: :hidden, name: 'ap_description', value: item_description) +
      tag(:input, type: :hidden, name: 'ap_returnurl', value: return_url) +
      tag(:input, type: :hidden, name: 'ap_cancelurl', value: cancel_url) +
      tag(:input, type: :hidden, name: 'apc_1', value: order_id) +
      tag(:input, type: :image,  name: 'ap_image', src: 'https://www.payza.com/images/payza-buy-now.png')
    end

  end
end