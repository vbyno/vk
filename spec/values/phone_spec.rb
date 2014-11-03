require 'spec_helper'

describe Phone do
  describe '.valid?' do
    it 'is true if phone has 12 dights' do
      expect(described_class.valid?('1234567')).to be_falsey
      expect(described_class.valid?('12345678901a')).to be_falsey
      expect(described_class.valid?('123456789012')).to be_truthy
    end
  end

  describe '#to_s' do
    it 'returns string' do
      expect(described_class.new(1234).to_s).to eq '1234'
      expect(described_class.new('1234').to_s).to eq '1234'
    end
  end
end
