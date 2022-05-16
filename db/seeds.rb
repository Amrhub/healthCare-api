# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

patient = Patient.first_or_create(weight: 80, height: 180, smoking: false)
user = User.first_or_create(first_name: 'Nicolae', last_name: 'Pop', phone: '+201000287983', gender: 'strongMale', 
  birth_date: '28-11-1988', age: 33, address: 'somewhere', reference_id: patient.id, role: 'patient', email: 'test@test.com', password: 'test123', password_confirmation: 'test123')
device_category = DeviceCategory.create(device_name: 'ECG', price: 300, device_items: 'ECG')
device = Device.create(device_category_id: device_category.id, patient_id: patient.id)
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-06T21:42:40.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-06T21:42:42.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-06T22:42:40.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-06T22:42:50.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-07T21:42:40.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-07T21:42:44.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-07T22:42:44.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 37.5, created_at: "2022-05-07T22:42:44.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 40, created_at: "2022-05-07T23:42:44.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 42, created_at: "2022-05-07T23:42:44.625Z")
DeviceDatum.create(device_id: device.id, spo2: 90.0, heart_rate: 80, temperature: 42, created_at: "2022-05-07T0:42:44.625Z")
