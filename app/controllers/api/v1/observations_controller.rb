class Api::V1::ObservationsController < ApplicationController
  before_action :set_observation, only: %i[show update destroy]

  # GET /observations
  def index
    params.require(:doctor_id)
    @observations = Observation.where(doctor_id: params[:doctor_id])
    @observations = @observations.map  { |observation| json_format_observation(observation) }

    render json: @observations
  end

  # Get /obersvations/my_consultants?patient_id=1
  def my_consultants
    params.require(:patient_id)
    @observations = Observation.where(patient_id: params[:patient_id])
    @observations = @observations.map  { |observation| json_format_observation(observation) }

    render json: @observations
  end

  # POST /observations
  def create
    @observation = Observation.new(observation_params.merge(status: 'pending'))

    if @observation.save
      render json: json_format_observation(@observation), status: :created
    else
      render json: @observation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /observations/1
  def update
    if @observation.update(observation_params)
      render json: @observation
    else
      render json: @observation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @observation.destroy
  end

  private

  def json_format_observation(observation)
    patient_info = User.find_by(reference_id: observation.patient_id, role: 'patient')
      {
        **observation.attributes,
        patientInfo: {
          id: patient_info.id,
          name: "#{patient_info.first_name} #{patient_info.last_name}",
          profilePic: patient_info.profile_pic.attached? ? url_for(patient_info.profile_pic) : nil,
        }
      }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_observation
    @observation = Observation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def observation_params
    params.permit(:patient_id, :doctor_id, :status)
  end
end
