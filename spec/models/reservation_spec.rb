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

require 'spec_helper'

describe Reservation do
  it { expect(subject).to belong_to :apartment }

  it_behaves_like 'presence validator',
    [:apartment, :check_in, :check_out,
     :customer_name, :customer_email, :customer_phone]

  it { expect(subject).to validate_inclusion_of(:status).in_array Reservation::STATUSES }

  context 'customer_email format' do
    it { expect(subject).to allow_value('some_email@gmail.comx').for :customer_email }
    it { expect(subject).not_to allow_value('some_emailgmail.comx').for :customer_email }
  end

  it 'sets pending status before validation' do
    reservation = build :reservation, status: nil
    expect(reservation).to be_valid
    expect(reservation.status).to eq Reservation::PENDING
  end

  it 'validates customer_phone' do
    expect(subject).to allow_value('123456789012').for(:customer_phone)
    expect(subject).not_to allow_value('12345678901').for(:customer_phone)
    expect(subject).not_to allow_value('12345678901a').for(:customer_phone)
  end
end
