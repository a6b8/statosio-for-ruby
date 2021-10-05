require './lib/statosio'
require 'open-uri'
require 'json'

# Initialize Statosio
statosio = Statosio::Generate.new

# Load Sample Dataset
url = 'https://d3.statosio.com/data/performance.json'
content = URI.open( url ).read
dataset = JSON.parse( content )

# Generate chart as .svg
compare = statosio.svg(
    dataset: dataset,
    x: 'name',
    y: 'mobile',
    options: {}
)

original = File.read( './test/example/compare.svg' )

if original.eql? compare
    puts "Test passed."
    exit 0
else
    puts "Test not passed."
    exit 1
end