require 'spec_helper'

shared_examples 'apartment_presenter' do |prefixes|
  prefixes.each do |prefix|
    context 'crud' do
      delegate :permalink, to: :apartment

      it 'does not routes to #index' do
        expect(get "#{prefix}/apartments").not_to route_to('apartments#index')
      end

      it 'routes to #show' do
        expected_params = { controller: 'apartments',
                            action: 'show',
                            permalink: permalink }
        expected_params.merge!(locale: prefix.to_s) if prefix

        expect(get "#{prefix}/apartments/#{permalink}").to route_to(expected_params)
      end

      it 'does not route other methods' do
        expect(post "#{prefix}/apartments").to_not be_routable
        expect(put "#{prefix}/apartments/#{permalink}").to_not be_routable
        expect(delete "#{prefix}/apartments/#{permalink}").to_not be_routable
      end
    end
  end
end

describe ApartmentsController do
  let(:apartment) { create :apartment }

  it_behaves_like 'apartment_presenter', Locale::SECONDARY + [nil]

  context 'root parser' do
    it 'parse apartment_path' do
      expect(get apartment_path(apartment.permalink)).to route_to(
        controller: 'apartments', action: 'show', permalink: apartment.permalink
      )
    end
  end

  it 'parse apartment_path' do
    expect(get locale_apartment_path(Locale::PL, apartment.permalink)).
      to route_to(controller: 'apartments', action: 'show',
                  permalink: apartment.permalink, locale: 'pl')
  end
end
