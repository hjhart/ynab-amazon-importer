## Synopsis

This project should allow a user to export orders successfully from Amazon, and into [the new YNAB][the_new_ynab] (https://app.youneedabudget.com). It does it by downloading a couple of order exports from amazon, parsing the data, and spitting out a CSV which can be dragged into the you need a budget interface.

## Code Example

Output a file to STDOUT:

```
./bin/export_to_ynab amazon_orders_and_shipments.csv amazon_items.csv
```

Output a file to a csv file

```
./bin/export_to_ynab amazon_orders_and_shipments.csv amazon_items.csv > amazon_orders.csv
```

## Motivation

I spend a lot of money on Amazon. I spend even more time importing my transactions into YNAB.

Manually going through my order history, clicking on each individual invoice (to determine which transactions map to a specific shipment), and THEN categorizing is expensive.

Hopefully this project eventually makes most of the busy work go away.

## Installation

```bash
git clone https://github.com/hjhart/ynab-amazon-importer.git
cd ynab-amazon-importer
bundle install
```

## How to use

Go here: [https://www.amazon.com/gp/b2b/reports](https://www.amazon.com/gp/b2b/reports)

Export two different CSVs, with Report Type set to 'Items' and one for 'Orders and shipments'.

!["Order Report Histroy Screenshot"][order_report]

Once they fully export (takes a while) you'll use both of these as inputs for the ruby script.

```
./bin/export_to_ynab amazon_orders_and_shipments.csv amazon_items.csv > amazon_orders.csv
```

Now, drag navigate to [the new YNAB][the_new_ynab], click on the credit card account that you use on amazon, and the `amazon_orders.csv` file anywhere in the browser. It should then show an import message with all of your transactions.

## Todo:

• Implement an initial script.
• Support multiple credit cards.
• Support split transactions when a single shipment has multiple items.
• If "release date" in the items CSV is in the future, schedule a transaction.

## Tests

```bash
git clone https://github.com/hjhart/ynab-amazon-importer.git
cd ynab-amazon-importer
bundle install
bundle exec rspec
```

## Contributors

James Hart
_Your name here!!!_

## License

MIT


[order_report]: https://raw.githubusercontent.com/hjhart/ynab-amazon-importer/master/images/order_history_reports.png "Order Report Histroy Screenshot"

[the_new_ynab]: https://app.youneedabudgget.com