# == Schema Information
#
# Table name: reservations
#
#  id             :integer          not null, primary key
#  apartment_id   :integer          not null
#  customer_name  :string(255)      not null
#  customer_email :string(255)      not null
#  check_in       :datetime         not null
#  check_out      :datetime         not null
#  status         :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Reservation < ActiveRecord::Base
  STATUSES = [
    BOOKED = 'Booked',
    PENDING = 'Pending',
    CANCELLED = 'Cancelled'
  ]

  belongs_to :apartment

  before_validation :set_default_status, on: :create

  validates :apartment, :customer_name, :customer_email, :check_in, :check_out, :status,
            presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :customer_email, format: { with: Devise.email_regexp }

private
  def set_default_status
    self.status = PENDING unless status
  end
end
