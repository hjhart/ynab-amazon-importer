class Order
  include Virtus.model

  attribute :id, String
  attribute :fulfillments, Array[Fulfillment]
  attribute :items, Array[Item]

  def transaction_csv
    csv = CSV.generate do |csv|
      csv << %w{Date Payee Category Memo Outflow Inflow}
      self.fulfillments.each do |fulfillment|
        item = self.items.find { |item| item.total_price == fulfillment.total_price }
        csv << [fulfillment['shipment_date'], 'Amazon.com', nil, item.title, item.total_price, nil] unless item.nil?
      end
    end
  end
end