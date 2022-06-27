class DeviceCategory < ApplicationRecord
  has_many :devices

  validates :device_name, presence: true
  validates :device_items, presence: true
  validates :price, presence: true
end
