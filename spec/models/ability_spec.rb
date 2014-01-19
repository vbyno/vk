require 'spec_helper'
require 'cancan/matchers'

shared_examples 'it can read all' do
  it 'is able to read all' do
    expect(subject).to be_able_to(:read, :all)
  end
end

shared_examples 'it is not able to manage global resources' do
  let(:global_resources) { { apartment: build(:apartment),
                             apartment_translation: build(:apartment_translation) } }

  it 'is not able to manage anything' do
    global_resources.each do |resource, object|
      expect(subject).to_not be_able_to(:create, resource)
      expect(subject).to_not be_able_to(:update, object)
      expect(subject).to_not be_able_to(:delete, object)
    end
  end
end

describe Ability do
  let(:admin_ability) { Ability.new(build :admin) }
  let(:user_ability) { Ability.new(build :user) }
  let(:guest_ability) { Ability.new(nil) }

  describe 'Admin ability' do
    it 'is able to manage all' do
      expect(admin_ability).to be_able_to(:manage, :all)
    end
  end

  describe 'User ablility' do
    subject { user_ability }

    it_behaves_like 'it can read all'
    it_behaves_like 'it is not able to manage global resources'
  end

  describe 'Guest ability' do
    subject { guest_ability }

    it_behaves_like 'it can read all'
    it_behaves_like 'it is not able to manage global resources'
  end
end
