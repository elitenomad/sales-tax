# Sales::Tax

Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical
products that are exempt. Import duty is an additional sales tax applicable on all imported
goods at a rate of 5%, with no exemptions.

When I purchase items I receive a receipt that lists the name of all the items and their price
(including tax), finishing with the total cost of the items, and the total amounts of sales taxes
paid. The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains
(np/100 rounded up to the nearest 0.05) amount of sales tax.

# Goal

Given a receipt with details, print correct price per product, total price and sales taxes. Output will be displayed on the console.
### Input data

```
    Quantity, Product, Price
    1, book, 12.49
    1, music cd, 14.99
    1, chocolate bar, 0.85
```

```
    Quantity, Product, Price
    1, imported box of chocolates, 10.00
    1, imported bottle of perfume, 47.50
```

```
    Quantity, Product, Price
    1, imported bottle of perfume, 27.99
    1, bottle of perfume, 18.99
    1, packet of headache pills, 9.75
    1, box of imported chocolates, 11.25
```

## Development or Installation

Download the sales-tax.zip into your local folder (OR)

```
git clone git@github.com:elitenomad/sales-tax.git
cd sales-tax
bundle install

(or)

cd sales-tax
bin/setup

```

- After checking out the repo, run `bin/setup` to install dependencies.
- Then, run `rake spec` to run the tests. 
- You can also run `bin/console` for an interactive prompt that will allow you to experiment.
    
## Directory structure

```
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── bin
│   ├── console
│   └── setup
├── data   => Directory where the input files are placed
│   ├── receipt-1.txt
│   ├── receipt-2.txt
│   └── receipt-3.txt
├── exe   => Directory where simulator is in. 
│   └── simulator
├── lib
│   └── sales
│       ├── tax
│       │   ├── build_product.rb => Forms the `Product` entities by parsing the entries in the file.
│       │   ├── calculate.rb => Helper class to perform calculations given `quantity, price`
│       │   ├── cli.rb     => Loads input receipt data and calls ReceiptFormatter class
│       │   ├── product.rb => Class which represents the `entry` in a receipt
│       │   ├── receipt.rb => Class which holds lists of products and has generate report logic
│       │   ├── receipt_formatter.rb => Outputs the required calculations onto the console.
│       │   └── version.rb
│       └── tax.rb
├── sales-tax.gemspec
└── spec  => Tests for the project.
```

## Usage

Note: Ensure latest ruby is installed on the system.

1. Unzip the sales-tax.zip
2. cd sales-tax
3. Run simulator with filename as argument.

```
./exe/simulator ./data/receipt-1.txt
./exe/simulator ./data/receipt-2.txt
./exe/simulator ./data/receipt-3.txt

```

## Test

```
rspec spec/
```

or

```
rake spec
```
# Design

Flow of control:

 => Simulator (is called with file as an argument)
     => Sales::Tax::CLI
        => Sales::Tax::BuildProduct
            => Sales::Tax::Product
            => Sales::Tax::BuildProduct#Entry
        => Sales::Tax::Receipt
            => Sales::Tax::Product
                => Sales::Tax::Calculate
        => Sales::Tax:ReceiptFormatter


`Sales::Tax::CLI` class loads input data file and passes the products to `Sales::Tax::Receipt` class which inturn generates the report and `Sales::Tax:ReceiptFormattr` displays it on the console.

## Considerations

1. Used `bundle gem`  to create a folder structure.

## Assumptions

1. Used only limited set of exemption list taken from the problem statement. 
2. Any product which has `imported` in its name is considered imported.
3. Receipt entries will have values all the time.
4. Price of the product is always greater than 0.0 :)

## Scope for Enhancement

- There is a scope to improve fetching of Exemption List logic based on a config file. Makes it more flexible than a simple array
- Display format is basic. We can use libraries to show it in more readable format. We can add a flexibility of choosing multiple formatters by providing options from command line.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
