class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :requester_ids, class_name: 'Friendship', foreign_key: 'requester_id'
  has_many :requestee_ids, class_name: 'Friendship', foreign_key: 'requestee_id'
  has_one_attached :profile_pic
end
