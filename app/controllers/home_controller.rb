class HomeController < ApplicationController
  def index
    render json: {
      message: 'Welcome to the API current version is v1'
    }
  end
end
