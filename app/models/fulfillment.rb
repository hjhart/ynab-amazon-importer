class MoneyAttribute < Virtus::Attribute
  def coerce(value)
    Monetize.parse(value)
  end
end

class DateAttribute < Virtus::Attribute
  def coerce(value)
    return nil if value.nil?
    Date.strptime(value, '%m/%d/%y')
  end
end


class Fulfillment
  include Virtus.model

  attribute :shipment_date, DateAttribute
  attribute :total_price, MoneyAttribute
  attribute :tracking_number, String
end
