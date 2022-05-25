class Friendship < ApplicationRecord
  validates :requester_id, presence: true
  validates :requestee_id, presence: true
end
