# statosio.rb

Statosio.rb is based on [statosio.js](https://github.com/a6b8/statosio.js) and helps to generate simple charts, in a fast and reliable way.

Statosio generates charts in the ```.svg``` format. Optimized for usage with [prawn-svg](https://github.com/mogest/prawn-svg) to generate documents in ```.pdf```. All Charts Data can be searched no information get lost.


✔️ build simple diagrams fast and reliable, with one function!<br>
✔️ pure javascript, no additonal css.<br>
✔️ highly customizable with 40+ style and data options.<br>


## Chart Types
### Bar
![# d3.statosio](https://d3.statosio.com/assets/images/example-bar-400.jpg)<br>
[Create simple bar chart](https://d3.statosio.com/tutorials/simple-bar-chart.html)
### Point
![# d3.statosio](https://d3.statosio.com/assets/images/example-point-400.jpg)<br>
[Create a simple point chart](https://d3.statosio.com/tutorials/simple-point-chart.html)
### Stacked
![# d3.statosio](https://d3.statosio.com/assets/images/example-stacked-bar-400.jpg)<br>
[Create simple stacked bar chart](https://d3.statosio.com/tutorials/simple-stacked-bar-chart.html)

## Features
### Select
![# d3.statosio](https://d3.statosio.com/assets/images/example-select-400.jpg)<br>
[Select and change position of columns](https://d3.statosio.com/tutorials/select-data.html)
### Sort Data
![# d3.statosio](https://d3.statosio.com/assets/images/example-sort-400.jpg)<br>
[Sort dataset by values](https://d3.statosio.com/tutorials/sort-data.html)
### Change Style
![# d3.statosio](https://d3.statosio.com/assets/images/example-customize-400.jpg)<br>
[Change style to dark-mode](https://d3.statosio.com/tutorials/change-style.html)


## Statosio

```ruby
require 'statosio'
chart = Statosio.new
chart.generate(
    dataset: nil,
    x: nil,
    y: nil,
    options: {}
)
``````

| | **Value** | **Type** | **Required** |
|------:|:------|:------| :------|
| **dataset** | ```[{},{}...]``` | Array of Hash | yes |
| **x** | ```"name"``` | String | yes |
| **y** | ```"mobile"```, ```[ "mobile",... ]``` | String or Array of Strings | yes |
| **options** | ```{}``` | Hash | yes |
| **silent** | ```true``` or ```false```| Boolean | no |


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'statosio'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install statosio

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/a6b8/statosio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a6b8/statosio/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Statosio project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a6b8/statosio/blob/master/CODE_OF_CONDUCT.md).
