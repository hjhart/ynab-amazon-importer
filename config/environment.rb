require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'csv'

require_relative '../app/models/fulfillment'
require_relative '../app/models/item'
require_relative '../app/models/order'
require_relative '../app/models/order_loader'
require_relative '../app/models/transaction_resolver'

# Huh? https://github.com/RubyMoney/money/issues/593
I18n.enforce_available_locales = false