class Api::V1::DeviceDataController < ApplicationController
  before_action :set_device_datum, only: %i[show]

  # GET /device_data
  def index
    @device_data = DeviceDatum.all

    render json: @device_data
  end

  # GET /device_data/1
  def show
    render json: @device_datum.last
  end

  def show_recent_ecg_data
    # 60 is because we save data from device to back-end each second
    @device_data = DeviceDatum.where(device_id: params[:device_id]).select(:ecg, :id, :device_id, :created_at).last

    render json: @device_data
  end

  def show_avg_hourly_data
    @device_data = []
    @device_data_day = DeviceDatum.where(device_id: params[:device_id]).order(:created_at).group_by { |t| t.created_at.strftime('%Y-%m-%d') }

    get_average_hourly_data(@device_data_day)

    render json: @device_data
  end

  # POST /device_data
  def create
    @device_datum = DeviceDatum.new(device_datum_params)
    @device_datum.ecg = params[:ecg]
    @device_datum.gps = params[:gps]

    if @device_datum.save
      render json: @device_datum, status: :created
    else
      render json: @device_datum.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_device_datum
    @device_datum = DeviceDatum.where(device_id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def device_datum_params
    params.permit(:device_id, :spo2, :heart_rate, :temperature, :ecg, :gps)
  end

  def get_average_hourly_data(device_data_day)
    device_data_day.each do |date, value|
      history = []
      data_history = []
      value.group_by { |t| t.created_at.strftime('%H') }.each do |hour, data_hourly|
        avg_data_per_hour = get_avg_data(data_hourly)

        hour = format_hour_to_12_hour_format(hour.to_i)
        history << { time: hour, **avg_data_per_hour }
        data_history << { **avg_data_per_hour }
      end
      avg_data_per_day = get_avg_data(data_history)
      @device_data << { date:, **avg_data_per_day, history: }
    end
  end

  def format_hour_to_12_hour_format(hour)
    if hour < 12
      return '12 AM' if hour.zero?

      "#{hour} AM"
    elsif hour == 12
      '12 PM'
    elsif hour - 12 < 10
      "0#{hour - 12} PM"
    else
      "#{hour - 12} PM"
    end
  end

  def get_avg_data(data)
    spo2_avg = 0
    heart_rate_avg = 0
    temperature_avg = 0

    data.each do |value|
      next unless value[:spo2] or value[:heart_rate] or value[:temperature]

      spo2_avg += value[:spo2]
      heart_rate_avg += value[:heart_rate]
      temperature_avg += value[:temperature]
    end

    spo2_avg /= data.length
    heart_rate_avg /= data.length
    temperature_avg /= data.length

    spo2_avg = spo2_avg.round(2)
    heart_rate_avg = heart_rate_avg.round(2)
    temperature_avg = temperature_avg.round(2)
    { heart_rate: heart_rate_avg, temperature: temperature_avg, spo2: spo2_avg }
  end
end
