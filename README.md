## Synopsis

This project should allow a user to export orders successfully from Amazon, and into the new YNAB (app.youneedabudget.com). It does it through downloading a couple of order exports from amazon, parsing the data, and spitting out a CSV which can be dragged into the you need a budget interface.

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
