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
  let(:picture) { build :picture }

  it_behaves_like 'presence validator', [:imageable]

  it { expect(subject).to belong_to(:imageable) }

  specify 'image validation' do
    expect(build :picture, image: nil).not_to be_valid
  end

  it 'creates picture' do
    expect(picture).to be_valid
    expect { picture.save! }.to_not raise_error
  end
end
