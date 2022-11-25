class Car < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user

  has_many :bookings, dependent: :destroy

  has_many_attached :photos

  validates :model, presence: true
  validates :brand, presence: true
  validates :year, presence: true
  validates :description, presence: true, length: { maximum: 40 }
  validates :longdescription, presence: true, length: { maximum: 240 }
  validates :address, presence: true
  validates :price_per_day, presence: true
  validates :photos, presence: true, on: :create

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[model brand address],
                  using: {
                    tsearch: { prefix: true }
                  }
end
