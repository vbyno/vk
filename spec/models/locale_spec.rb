require 'spec_helper'

describe Locale do
  let(:ru_locale) { Locale.new(:ru) }
  let(:en_locale) { Locale.new(:en) }

  it 'has appropriate locales lists' do
    expect(Locale::ALL_LOCALES).to eq [:ru, :ua, :en, :pl]
    expect(Locale::SECONDARY_LOCALES).to eq [:ua, :en, :pl]
  end

  describe '.new!' do
    it 'creates new locale object' do
      expect(Locale).to receive(:new).with(:en).and_return en_locale
      expect(Locale.new!(:en)).to eq en_locale
    end

    it 'changes current locale' do
      I18n.locale = :ru
      Locale.new!(:en)
      expect(I18n.locale).to eq :en
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

  describe '#url_options' do
    it 'returns an empty hash if locale is default' do
      expect(ru_locale.url_options).to eq({})
    end

    it 'returns hash with locale attribute' do
      expect(en_locale.url_options).to eq({ locale: :en })
    end
  end

  describe '#change_current_to' do
    it 'changes current locale' do
      I18n.locale = :ru
      expect { en_locale.change_current! }.to change { I18n.locale }.from(:ru).to(:en)
    end
  end
end