class Doctor < ApplicationRecord
  has_many :observations
  has_many :patients, through: :observations
  has_many_attached :certificates
end
