class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all
    @users = @users.map do |user|
      {
        id: user.id,
        name: "#{user.first_name} #{user.last_name}",
        profilePic: user.profile_pic.attached? ? url_for(user.profile_pic) : nil
      }
    end

    render json: @users
  end

  # GET /users/1
  def show
    if @user.profile_pic.attached?
      render json: {
        **@user.attributes,
        profile_pic: url_for(@user.profile_pic)
      }
    else
      render json: {
        **@user.attributes,
        profile_pic: @user.profile_pic.attached? ? url_for(@user.profile_pic) : nil
      }
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def posts
    user = User.find(params[:user_id])
    render json: user.posts
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:first_name, :last_name, :phone, :gender, :birth_date,
                  :age, :address, :profile_pic, :bio)
  end
end
