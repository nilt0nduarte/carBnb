class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_date, presence: true,
                         comparison: { greater_than_or_equal_to: Date.today, message: "can't be smaller than today." }

  validates :end_date, presence: true,
                       comparison: { greater_than: :start_date, message: "can't book a car in the past." }


  def other_booking_overlap
  # run this validation if the other ones did pass
  if errors.blank?
    other_bookings = restaurant.bookings
    overlapping_bookings = other_bookings.select do |other_booking|
      period.overlaps?(other_booking.period)
    end
    is_overlapping = !overlapping_bookings.empty?
    errors.add(:base, "Picked date is not available") if is_overlapping
  end
end
end
