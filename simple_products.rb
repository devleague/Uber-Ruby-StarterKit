require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('https://sandbox-api.uber.com/v1/products')

parameters = {
  :server_token => ENV['UBER_SERVER_TOKEN'],
  :latitude => 21.3088619,
  :longitude => -157.8086674
}

uri.query = URI.encode_www_form( parameters )

response = Net::HTTP.get( uri )

puts JSON.pretty_generate( JSON.parse( response ) )

