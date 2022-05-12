class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = user_from_token
    render json: {
      message: "If you see this, you're in!",
      user:
    }
  end

  private

  def user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'],
                             ENV.fetch('DEVISE_JWT_SECRET_KEY', nil))[0] # He used rails credintials to create the JWT, I implemented it with figaro
    user_id = jwt_payload['sub']

    User.find(user_id.to_s)
  end
end
