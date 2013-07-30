require 'payza_payments'

PAYZA_CONFIG = YAML.load_file("#{Rails.root}/config/payza.yml")[Rails.env].symbolize_keys
PayzaPayments.sandbox! if PAYZA_CONFIG[:sandbox]