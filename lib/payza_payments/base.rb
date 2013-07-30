module PayzaPayments
  class Base
    include AttrRequired, AttrOptional

    attr_required :ipn_security_code, :merchant_email, :sandbox

    def initialize(attributes = {})
      if attributes.is_a?(Hash)
        (required_attributes + optional_attributes).each do |key|
          value = attributes[key]
          self.send "#{key}=", value
        end
      end
      attr_missing!
    end
  end
end