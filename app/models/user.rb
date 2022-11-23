class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, through: :cars

  has_one_attached :photo

  validates :first_name, presence: true, length: { in: 2..10 }
  validates :last_name, presence: true, length: { in: 2..20 }
  validates :phone_number, presence: true, length: { in: 5..10 }

end
