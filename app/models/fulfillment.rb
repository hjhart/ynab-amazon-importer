class MoneyAttribute < Virtus::Attribute
  def coerce(value)
    Monetize.parse(value)
  end
end


class Fulfillment
  include Virtus.model

  attribute :shipment_date, Date
  attribute :total_price, MoneyAttribute
end
