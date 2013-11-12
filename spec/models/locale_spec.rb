require 'spec_helper'

describe Locale do
  let(:en_locale_mock) do
    mock = double()
    mock.stub(:to_sym).and_return :en
    mock
  end
  let(:ru_locale) { Locale.new(:ru) }
  let(:en_locale) { Locale.new(:en) }

  it 'has appropriate locales lists' do
    expect(Locale::ALL_LOCALES).to eq [:ru, :ua, :en, :pl]
    expect(Locale::SECONDARY_LOCALES).to eq [:ua, :en, :pl]
  end

  describe '.new!' do
    it 'creates new object and changes locale' do
      Locale.should_receive(:new).and_return en_locale_mock
      expect(Locale.new!(:en)).to eq en_locale_mock
    end

    it 'changes current locale' do
      Locale.stub(:new).and_return en_locale_mock
      I18n.locale = :ru
      expect { Locale.new!(:en) }.to change { I18n.locale }.from(:ru).to(:en)
    end
  end

  describe '#initialize' do
    it 'assigns instance variable' do
      expect(Locale.new(:en).to_sym).to eq :en
    end

    it 'raises exception if locale not from the list' do
      expect {
        Locale.new(:fr)
      }.to raise_error(Exception, "locale 'fr' is not appropriate")
    end

    it 'set defauld :ru locale' do
      expect(Locale.new(nil).to_sym).to eq :ru
    end
  end

  describe '#default?' do
    it 'is true for russian locale' do
      expect(ru_locale.default?).to be_true
    end

    it 'is false for others' do
      expect(en_locale.default?).to be_false
    end
  end

  describe '#root_page_path' do
    it 'returns / for russian locale' do
      expect(ru_locale.root_page_path).to eq '/'
    end

    it 'returns /en for other locales' do
      expect(en_locale.root_page_path).to eq '/en'
    end
  end

  describe '#url_options' do
    xit 'TODO!' do
    end
  end

  describe '#to_sym' do
    it 'returns symbol' do
      expect(en_locale.to_sym).to eq :en
    end
  end

  describe '#to_s' do
    it 'returns string' do
      expect(en_locale.to_s).to eq 'en'
    end
  end
end