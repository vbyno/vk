require 'spec_helper'

describe ApartmentsController do
  let(:valid_attributes) {
    {
      title: 'MyString',
      price: '9.99',
      description: 'MyText'
    }
  }
  let(:valid_session) { {} }
  let!(:apartment) { Apartment.create! valid_attributes }

  describe 'GET index' do
    it 'assigns all apartments as @apartments' do
      get :index, {}, valid_session
      expect(assigns :apartments).to eq([apartment])
    end
  end

  describe 'GET show' do
    it 'assigns the requested apartment as @apartment' do
      get :show, { id: apartment.to_param }, valid_session
      expect(assigns :apartment).to eq(apartment)
    end
  end

  describe 'GET new' do
    it 'assigns a new apartment as @apartment' do
      get :new, {}, valid_session
      expect(assigns :apartment).to be_a_new(Apartment)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested apartment as @apartment' do
      get :edit, { id: apartment.to_param }, valid_session
      expect(assigns :apartment).to eq(apartment)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Apartment' do
        expect {
          post :create, { apartment: valid_attributes }, valid_session
        }.to change(Apartment, :count).by(1)
      end

      it 'assigns a newly created apartment as @apartment' do
        post :create, { apartment: valid_attributes }, valid_session
        expect(assigns :apartment).to be_a(Apartment)
        expect(assigns :apartment).to be_persisted
      end

      it 'redirects to the created apartment' do
        post :create, { apartment: valid_attributes }, valid_session
        expect(response).to redirect_to(Apartment.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved apartment as @apartment' do
        Apartment.any_instance.stub(:save).and_return(false)
        post :create, { apartment: { title: 'invalid value' } }, valid_session
        expect(assigns :apartment).to be_a_new(Apartment)
      end

      it "re-renders the 'new' template" do
        Apartment.any_instance.stub(:save).and_return(false)
        post :create, { apartment: { title: 'invalid value' } }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested apartment' do
        Apartment.any_instance.should_receive(:update).with({ 'title' => 'MyString' })
        put :update,
            { id: apartment.to_param, apartment: { title: 'MyString' } },
            valid_session
      end

      it 'assigns the requested apartment as @apartment' do
        put :update,
            { id: apartment.to_param, apartment: valid_attributes },
            valid_session
        expect(assigns :apartment).to eq(apartment)
      end

      it 'redirects to the apartment' do
        put :update,
            { id: apartment.to_param, apartment: valid_attributes },
            valid_session
        expect(response).to redirect_to(apartment)
      end
    end

    describe 'with invalid params' do
      it 'assigns the apartment as @apartment' do
        Apartment.any_instance.stub(:save).and_return(false)
        put :update, 
            { id: apartment.to_param, apartment: { title: 'invalid value' }},
            valid_session
        expect(assigns :apartment).to eq(apartment)
      end

      it "re-renders the 'edit' template" do
        Apartment.any_instance.stub(:save).and_return(false)
        put :update, 
            { id: apartment.to_param, apartment: { title: 'invalid value' } },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested apartment' do
      expect {
        delete :destroy, { id: apartment.to_param }, valid_session
      }.to change(Apartment, :count).by(-1)
    end

    it 'redirects to the apartments list' do
      delete :destroy, { id: apartment.to_param }, valid_session
      expect(response).to redirect_to(apartments_url)
    end
  end
end
