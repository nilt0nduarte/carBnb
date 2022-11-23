class Car < ApplicationRecord
  belongs_to :user

  has_many :bookings, dependent: :destroy

  has_many_attached :photos

  validates :model, presence: true
  validates :brand, presence: true
  validates :year, presence: true
  validates :description, length: { maximum: 40 }
  validates :price_per_day, presence: true
  validates :photos, presence: true
end
