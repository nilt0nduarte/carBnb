class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_date, presence: true,
                         comparison: { greater_than_or_equal_to: Date.today, message: "can't be smaller than today." }

  validates :end_date, presence: true,
                       comparison: { greater_than: :start_date, message: "can't book a car in the past." }

  validate :other_booking_overlap_start_date, :other_booking_overlap_end_date

  def other_booking_overlap_start_date
    # run this validation if the other ones did pass
    if errors.blank?
      other_bookings = car.bookings.where.not(id: self.id)
      overlapping_bookings = other_bookings.select do |other_booking|
        # period.overlaps?(other_booking.period)
        (other_booking.start_date..other_booking.end_date).to_a.include? self.start_date
      end
      is_overlapping = !overlapping_bookings.empty?
      errors.add(:start_date, "Picked date is not available") if is_overlapping
    end
  end

  def other_booking_overlap_end_date
    # run this validation if the other ones did pass
    if errors.blank?
      other_bookings = car.bookings.where.not(id: self.id)
      overlapping_bookings = other_bookings.select do |other_booking|
        # period.overlaps?(other_booking.period)
        (other_booking.start_date..other_booking.end_date).to_a.include? self.end_date
      end
      is_overlapping = !overlapping_bookings.empty?
      errors.add(:end_date, "Picked date is not available") if is_overlapping
    end
  end
end
