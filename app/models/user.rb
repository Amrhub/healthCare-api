class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :requester_ids, class_name: "Friendship", foreign_key: "requester_id"
    has_many :requestee_ids, class_name: "Friendship", foreign_key: "requestee_id"
end
