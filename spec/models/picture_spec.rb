# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  imageable_id   :integer          not null
#  imageable_type :string(255)      not null
#  image          :string(255)      not null
#  alt            :string(255)
#  title          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Picture do
  it_behaves_like 'presence validator', %i[imageable image]

  it { expect(subject).to belong_to(:imageable) }

  it 'creates picture' do
    create :picture
  end
end
