class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all
    @users = @users.map do |user|
      {
        id: user.id,
        name: "#{user.first_name} #{user.last_name}",
        profilePic: user.profile_pic.attached? ? url_for(user.profile_pic) : nil,
        role: user.role
      }
    end

    render json: @users
  end

  # GET /users/1
  def show
    if @user.role == 'patient'
      role_info = Patient.find(@user.reference_id)
      device_id = Device.find_by(patient_id: @user.reference_id)&.id
      render json: {
        **@user.attributes.except(:first_name),
        firstName: @user.first_name,
        lastName: @user.last_name,
        birthDate: @user.birth_date,
        profilePic: @user.profile_pic.attached? ? url_for(@user.profile_pic) : nil,
        role: @user.role,
        referenceId: @user.reference_id,
        roleInfo: { **role_info.attributes, device_id: }
      }
    else
      render json: {
        **@user.attributes.except(:first_name),
        firstName: @user.first_name,
        lastName: @user.last_name,
        birthDate: @user.birth_date,
        profilePic: @user.profile_pic.attached? ? url_for(@user.profile_pic) : nil,
        role: @user.role,
        referenceId: @user.reference_id
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
      render json: format_user_json(@user)
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

  def format_user_json(user)
    {
      id: user.id,
      profilePic: user.profile_pic.attached? ? url_for(user.profile_pic) : nil,
      firstName: user.first_name,
      lastName: user.last_name,
      email: user.email,
      role: user.role,
      referenceId: user.reference_id,
      bio: user.bio,
      phone: user.phone,
      address: user.address,
      gender: user.gender,
      birthDate: user.birth_date,
      age: user.age
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:first_name, :last_name, :phone, :gender, :birth_date,
                  :age, :address, :profile_pic, :bio, :password, :password_confirmation)
  end
end
