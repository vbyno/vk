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
#  body           :text
#  customer_phone :string(255)      not null
#

class Reservation < ActiveRecord::Base
  STATUSES = Set.new [
    BOOKED = 'Booked',
    PENDING = 'Pending',
    CANCELLED = 'Cancelled'
  ]

  belongs_to :apartment

  before_validation :set_default_status, on: :create
  before_validation :format_phone

  validates :apartment, :check_in, :check_out, :status,
            :customer_name, :customer_email, :customer_phone,
            presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :customer_email, format: { with: Devise.email_regexp }
  validates :customer_phone, phone: true

private
  def set_default_status
    self.status = PENDING unless status
  end

  def format_phone
    self.customer_phone = Phone.new(customer_phone).to_s
  end
end
