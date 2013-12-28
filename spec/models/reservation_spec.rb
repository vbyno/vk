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

require 'spec_helper'

describe Reservation do
  it { expect(subject).to belong_to :apartment }

  it { expect(subject).to validate_presence_of :apartment }
  it { expect(subject).to validate_presence_of :customer_name }
  it { expect(subject).to validate_presence_of :customer_email }
  it { expect(subject).to validate_presence_of :check_in }
  it { expect(subject).to validate_presence_of :check_out }
  it { expect(subject).to validate_presence_of :status }

  it { expect(subject).to(ensure_inclusion_of(:status).in_array Reservation::STATUSES) }

  it 'sets pending status before validation' do
    reservation = build :reservation, status: nil
    expect(reservation).to be_valid
    expect(reservation.status).to eq Reservation::PENDING
  end
end
