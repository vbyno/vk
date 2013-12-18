require 'spec_helper'

describe ApartmentsController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get '/apartments').to route_to('apartments#index')
    end

    it 'routes to #show' do
      expect(get '/apartments/1').to route_to('apartments#show', id: '1')
    end

    it 'does not route other methods' do
      expect(post '/apartments').to_not be_routable
      expect(put '/apartments/1').to_not be_routable
      expect(delete '/apartments/1').to_not be_routable
    end
  end
end
