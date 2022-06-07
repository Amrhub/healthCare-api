class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
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
        user: {
          **resource.attributes,
          profile_pic: resource.profile_pic.attached? ? url_for(@user.profile_pic) : nil
        }
      }, status: :ok
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: {
        message: 'Failed to sign up',
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.permit(:first_name, :last_name, :phone, :gender, :address, :role, :age,
                  :email, :password, :password_confirmation, :profile_pic, :birth_date, :reference_id, :bio)
  end
end
