class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_date, presence: true,
                         comparison: { greater_than_or_equal_to: Date.today, message: "can't be smaller than today." }

  validates :end_date, presence: true,
                       comparison: { greater_than: :start_date, message: "can't book a car in the past." }
end
