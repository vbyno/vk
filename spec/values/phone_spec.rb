require 'spec_helper'

describe Phone do
  describe '#to_s' do
    it 'returns string' do
      expect(described_class.new(1234).to_s).to eq '1234'
      expect(described_class.new('1234').to_s).to eq '1234'
    end
  end
end
