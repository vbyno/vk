require 'spec_helper'

shared_examples 'apartment_presenter' do |prefixes|
  prefixes.each do |prefix|
    context 'crud' do
      it 'does not routes to #index' do
        expect(get "#{prefix}/apartments").not_to route_to('apartments#index')
      end

      it 'routes to #show' do
        expected_params = { controller: 'apartments',
                            action: 'show',
                            id: '1' }
        expected_params.merge!(locale: prefix.to_s) if prefix

        expect(get "#{prefix}/apartments/1").to route_to(expected_params)
      end

      it 'does not route other methods' do
        expect(post "#{prefix}/apartments").to_not be_routable
        expect(put "#{prefix}/apartments/1").to_not be_routable
        expect(delete "#{prefix}/apartments/1").to_not be_routable
      end
    end
  end
end

describe ApartmentsController do
  let(:apartment) { create :apartment, :pure }

  it_behaves_like 'apartment_presenter', Locale::SECONDARY_LOCALES + [nil]

  context 'root parser' do
    it 'parse apartment_path' do
      expect(get apartment_path(apartment)).to route_to(
        controller: 'apartments', action: 'show', id: apartment.id.to_s
      )
    end

    it 'parse root_path' do
      expect(get root_path).to route_to(controller: 'apartments',
                                        action: 'index')
    end
  end

  context 'locale parser' do
    it 'parse apartment_path' do
      expect(get locale_apartment_path(Locale::PL, apartment)).
        to route_to(controller: 'apartments', action: 'show',
                    id: apartment.id.to_s, locale: 'pl')
    end

    it 'parse locale_root_path' do
      expect(get locale_root_path(Locale::PL)).
        to route_to(controller: 'apartments', action: 'index', locale: 'pl')
    end
  end
end
