class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.age = calculate_age(resource)
    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
      else
        expire_data_after_sign_in!
      end
      render json: {
        message: 'Signed up successfully',
        user: resource
      }, status: :ok
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: {
        message: 'Failed to sign up',
        errors: resource.errors
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.permit(:first_name, :last_name, :phone, :gender, :address, :role,
                  :email, :password, :password_confirmation, :profile_pic, :birth_date)
  end

  private

  def calculate_age(resource)
    (Date.today - resource.birth_date.to_date).to_i / 365
  end
end
