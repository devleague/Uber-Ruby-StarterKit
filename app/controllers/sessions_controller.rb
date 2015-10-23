class SessionsController < ActionController::Base

  def create
    render json: request.env['omniauth.auth']
  end

end
