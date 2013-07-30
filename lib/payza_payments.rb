require 'attr_required'
require 'attr_optional'
require 'payza_payments/version'
require 'payza_payments/base'
require 'payza_payments/ipn_handler'
require 'payza_payments/button_generator'

module PayzaPayments

  def self.sandbox!
    self.sandbox = true
  end

  def self.sandbox=(boolean)
    @@sandbox = boolean
  end

  def self.sandbox?
    @@sandbox
  end
  self.sandbox = false

end
