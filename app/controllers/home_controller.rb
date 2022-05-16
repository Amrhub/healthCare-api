class HomeController < ApplicationController
  def index
    render json: { message: 'Welcome to the API this current version is v1, please use the /api/v1/ routes' }
  end
end
