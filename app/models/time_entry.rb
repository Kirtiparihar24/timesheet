class TimeEntry < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :future_entry, :clock_out_after_clock_in, :overlapping_time_entries

  scope :incomplete, -> { where(clock_out: nil) }
  scope :complete, -> { where.not(clock_out: nil) }
  scope :active_timer, -> (user_id) { where(clock_in: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, clock_out: nil, user_id: user_id) }

  def time_spent
    self.clock_out.to_i - self.clock_in.to_i
  end

  private

  def future_entry
    errors.add(:clock_in, "Future time entries are not permitted.") if self.clock_in.present? && self.clock_in.future?
  end

  def clock_out_after_clock_in
    return if clock_out.blank? || clock_in.blank?

    if clock_out < clock_in
      errors.add(:clock_out, "Clock Out must be after the Clock In time")
    end
  end

  def overlapping_time_entries
    if (TimeEntry.where("(? BETWEEN clock_in AND clock_out OR ? BETWEEN clock_in AND clock_out) AND user_id = ? AND id != ?", self.clock_in, self.clock_out, self.user_id, self.id).any?)
       errors.add(:clock_out, 'This time slot already entered.')
    end
  end

end
