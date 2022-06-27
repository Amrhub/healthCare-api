class Api::V1::DevicesController < ApplicationController
  before_action :set_device, only: %i[show update destroy]

  # GET /devices
  def index
    @devices = Device.includes(:device_category)

    render json: @devices.map { |device| format_device(device) }
  end

  # GET /devices/1
  def show
    render json: @device
  end

  # POST /devices
  def create
    @device = Device.new(device_params)

    if @device.save
      render json: format_device(@device), status: :created
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
  end

  private

  def format_device(device)
    user = User.find_by(reference_id: device.patient_id, role: 'patient')
    {
      deviceId: device.id,
      patientId: device.patient_id,
      patientName: "#{user.first_name} #{user.last_name}",
      deviceCategoryId: device.device_category_id,
      deviceCategory: device.device_category.device_name
    }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_device
    @device = Device.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def device_params
    params.permit(:device_category_id, :patient_id)
  end
end
