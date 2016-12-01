class Order
  include Virtus.model

  attribute :id, String
  attribute :fulfillments, Array[Fulfillment]
  attribute :items, Array[Item]

  def transaction_csv
    csv = CSV.generate do |csv|
      csv << %w{Date Payee Category Memo Outflow Inflow}
      remaining_items = self.items.dup
      self.fulfillments.each do |fulfillment|
        items = TransactionResolver.new(remaining_items: remaining_items, fulfillment: fulfillment).items
        if items.size > 0
          csv << [fulfillment.shipment_date, 'Amazon.com', nil, items.map(&:title).join(' and '), fulfillment.total_price, nil]
          items.each { |item| remaining_items.delete(item) }
        else
          csv << [fulfillment.shipment_date, 'Amazon.com', nil, 'Unknown', fulfillment.total_price, nil]
        end
      end
    end
  end
end