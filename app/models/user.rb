class User < ApplicationRecord
  after_save :calculate_age_after_save

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :requester_ids, class_name: 'Friendship', foreign_key: 'requester_id'
  has_many :requestee_ids, class_name: 'Friendship', foreign_key: 'requestee_id'
  has_one_attached :profile_pic

  # validations
  validates :profile_pic, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  validates :phone, presence: true, length: { minimum: 10 }
  validates :address, presence: true
  validates :birth_date, presence: true
  validates :role, presence: true
  validates :reference_id, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :gender, presence: true

  def calculate_age_after_save
    self.age = (Date.today - birth_date.to_date).to_i / 365 unless birth_date.nil?
  end
end
