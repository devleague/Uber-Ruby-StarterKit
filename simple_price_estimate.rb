require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('https://sandbox-api.uber.com/v1/estimates/price')

parameters = {
  :server_token => ENV['UBER_SERVER_TOKEN'],
  :start_latitude => 21.3088619,
  :start_longitude => -157.8086674,
  :end_latitude => 21.2965912,
  :end_longitude => -157.8564657
}

uri.query = URI.encode_www_form( parameters )

response = Net::HTTP.get( uri )

puts JSON.pretty_generate( JSON.parse( response ) )

