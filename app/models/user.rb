class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :bookings, through: :cars
  has_many :cars, dependent: :destroy
  has_many :bookings_as_owner, through: :cars, source: :bookings

  validates :first_name, presence: true, length: { in: 2..10 }
  validates :last_name, presence: true, length: { in: 2..20 }
  validates :phone_number, presence: true, length: { in: 5..10 }
  validates :photo, presence: true
end
