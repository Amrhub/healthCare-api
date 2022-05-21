class Patient < ApplicationRecord
  has_many :devices
  has_many :observations
  has_many :doctors, through: :observations

  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :smoking, inclusion: { in: [true, false] }
  validates :covid, inclusion: { in: [true, false] }
  validates :hypertension, inclusion: { in: [true, false] }
  validates :diabetes, inclusion: { in: [true, false] }
end
