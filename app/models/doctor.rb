class Doctor < ApplicationRecord
  has_many :observations
  has_many :patients, through: :observations
  has_many_attached :certificates

  validates :specialization, presence: true
  validates :years_experience, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :salary, presence: true, numericality: { greater_than: 0 }
end
