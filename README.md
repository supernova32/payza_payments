# PayzaPayments
[![Build Status](https://travis-ci.org/FreedomVPN/liberty_reserve_payments.png?branch=master)](https://travis-ci.org/FreedomVPN/liberty_reserve_payments)

Configure buttons for Payza based on your requirements and validate IPN requests sent by Payza.
With this gem the user of your shop can pay for a digital item (or any type of item) and you can validate the transaction
after it was made.

## Installation

Add this line to your application's Gemfile:

    gem 'payza_payments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payza_payments

## Usage

After the installation, you still need two files for the gem to work. A Yaml config file and an initializer.

### config/payza.yml
```yaml
development:
  ipn_security_code: xhs123457
  merchant_email: sample@example.com
  sandbox: true

production:
  ipn_security_code: xhs123457
  merchant_email: sample@example.com
  sandbox: false

test:
  ipn_security_code: xhs123457
  merchant_email: sample@example.com
  sandbox: true
```

### config/initializers/payza.rb
```ruby
require 'payza_payments'

PAYZA_CONFIG = YAML.load_file("#{Rails.root}/config/payza.yml")[Rails.env].symbolize_keys
```

After creating these files you still need to add the methods provided by this gem to your PaymentsController.
To do this you can add the following template methods to you file:

```ruby
def pay_item_with_payza
    # With this you will pass the ButtonGenerator instance to the view
    # in order to be able to get the button in your view with the correct
    # parameters.
    @payza = PayzaPayments::ButtonGenerator.new PAYZA_CONFIG
    @invoice = Invoice.new(params[:invoice])
end
```

There are two methods for generating buttons. `.generate_simple_button` and
`.generate_subscription_button`. Both take similar parameters:
```ruby
# action points to the current view
# order_id can be any identifier you want. It should allow you to match
# the IPN request to something in your application.
.generate_simple_button(action, purchase_type, item_name, amount, currency,
                        return_url, cancel_url, item_description, order_id)

# time_unit: can be 'Day', 'Week', 'Month', 'Year'
# period_length: gives how long the subscription will be, depending on time_unit
# it can go from 1 to 90.
.generate_subscription_button(action, purchase_type, item_name, amount, currency,
                              return_url, cancel_url, item_description, order_id,
                              time_unit, period_length)
```
The code in the view may look like this (Haml example)
```haml
= @payza.generate_simple_button(self, :item, 'Sample item', 5, 'EUR', 'http://exa.co/success',
                                'http://exa.co/cancel', 'Sample Desc', @invoice.id)

```
You should also add a route for Payza to send the IPN notifications. This gem supports both v1 and v2
of Payza. PayzaPayments will only validate the basic verification parameters. After a successful validation
you should still manually go through the parameters in order to match the payment to a corresponding order.

It can point to a method looking like this:

```ruby
def validate_ipn_v2
    handler = PayzaPayments::IpnHandler.new PAYZA_CONFIG
    response = handler.handle_ipn_v2(params[:token])
    if response == 'INVALID REQUEST'
        # Response is not valid, log it and review it later
    else
        # The transaction has been successfully verified
        # use the response hash to validate it has the
        # correct data. You should use response['apc_1'] to
        # fetch the order id, or any other parameter you passed
        # on the view to validate against your DB.
        invoice = Invoice.find(response['apc_1'])
        if (response['ap_merchant'] == handler.merchant_email and
           response['ap_status'] == 'Success' and response['ap_amount'] == invoice.amount)
           # Now we know that the transaction was successful, the amount matches and
           # the payment was sent to us. For a list of all the IPN variables go to
           # https://dev.payza.com/resources/references/ipn-variables
        else
           # Something devious has happened!
        end
    end
end

def validate_ipn
    handler = ...
    response = handler.handle_ipn(params)
    if response == true
        # params[:ap_securitycode] and params[:ap_merchant] have already been
        # validated. You should still validate the rest.
    else
        # INVALID
    end
end

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
