class ApplicationController < ActionController::API
  def user_from_id(id)
    user = User.find(id)
    return unless user.present?

    user_info = format_user_data(user)
    case user.role
    when 'doctor'
      doctor = Doctor.find(user.reference_id)
      {
        userInfo: user_info,
        roleInfo: format_doctor_data(doctor)
      }
    when 'patient'
      patient = Patient.find(user.reference_id)
      {
        userInfo: user_info,
        roleInfo: format_patient_data(patient)
      }
    end
  end

  def format_user_data(user)
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

  def format_doctor_data(doctor)
    {
      specialization: doctor.specialization,
      experience: doctor.years_experience,
      salary: doctor.salary,
      certificates:
        doctor.certificates.attached? ? doctor.certificates.map { |file| url_for(file) } : 'No certificates'
    }
  end

  def format_patient_data(patient)
    {
      deviceId: patient.device&.id,
      weight: patient.weight,
      height: patient.height,
      smoking: patient.smoking,
      covid: patient.covid,
      diabetes: patient.diabetes,
      hypertension: patient.hypertension,
      otherDiseases: patient.other_diseases_detail
    }
  end
end
