# NQL

[![Build Status](https://travis-ci.org/gabynaiman/nql.png)](https://travis-ci.org/gabynaiman/nql)

Natural Query Language built on top of ActiveRecord and Ransack

## Installation

Add this line to your application's Gemfile:

    gem 'nql'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nql

## Supported comparators

    --------------------------------------
    | Symbol | Description               |
    --------------------------------------
    | :      | Contains                  |
    | =      | Equals                    |
    | !=     | Not equals                |
    | >      | Grater than               |
    | >=     | Grater or equals than     |
    | <      | Less than                 |
    | <=     | Less or equals than       |
    | ~      | Matches (eq ignore case)  |
    --------------------------------------


## Usage

Converts from natural language to query expression

    Country.nql('(name: arg | name: br) & region = south').to_sql
    => "SELECT coutries.* FROM countries WHERE (countries.name LIKE '%arg%' OR countries.name LIKE '%br%') AND region = 'south'"

### Joins support

    Country.nql('cities.name: buenos').to_sql
    => "SELECT countries.* FROM countries LEFT OUTER JOIN cities ON countries.id = cities.country_id WHERE cities.name LIKE '%buenos%'"

### Invalid expressions handling

Safe query

    Country.nql('xyz').to_sql
    => "SELECT coutries.* FROM countries WHERE (1=2)

Raising exceptions

    Country.nql!('xyz') => raise NQL::SyntaxError

    Country.nql!('xyz: arg') => raise NQL::AttributesNotFoundError

    Country.nql!(1234) => raise NQL::DataTypeError

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
