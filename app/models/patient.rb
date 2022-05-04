class Patient < ApplicationRecord
    has_many :devices
    has_many :observations
    has_many :doctors, through: :observations
end
