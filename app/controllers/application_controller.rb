require 'net/http'
require 'uri'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def profile
    uri = URI.parse('https://sandbox-api.uber.com/v1/me')

    request = Net::HTTP::Get.new( uri )
    request['Authorization'] = "Bearer #{params[:access_token]}"
    puts request['Authorization']
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
      http.request(request)
    }

    render json: response.body
  end

end
