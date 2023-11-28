# frozen_string_literal: true

require 'rails_helper'

describe MapController do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @states and @states_by_fips_code' do
      state = create(:state)
      get :index
      expect(assigns(:states)).to eq([state])
      expect(assigns(:states_by_fips_code)).to eq({ state.std_fips_code => state })
    end
  end

  describe 'GET #state' do
    it 'renders the state template' do
      state = create(:state)
      get :state, params: { state_symbol: state.symbol }
      expect(response).to render_template(:state)
    end

    it 'assigns @state and @county_details' do
      state = create(:state)
      county = create(:county, state_id: state.id)
      get :state, params: { state_symbol: state.symbol }
      expect(assigns(:state)).to eq(state)
      expect(assigns(:county_details)).to eq({ county.std_fips_code => county })
    end

    it 'redirects to root_path when state is not found' do
      get :state, params: { state_symbol: 'invalid_state' }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("State 'INVALID_STATE' not found.")
    end
  end

  describe 'GET #county' do
    it 'renders the county template' do
      state = create(:state)
      county = create(:county, state_id: state.id)
      get :county, params: { state_symbol: state.symbol, std_fips_code: county.std_fips_code }
      expect(response).to render_template(:county)
    end

    it 'assigns @state, @county, and @county_details' do
      state = create(:state)
      county = create(:county, state_id: state.id)
      get :county, params: { state_symbol: state.symbol, std_fips_code: county.std_fips_code }
      expect(assigns(:county)).to eq(county)
      expect(assigns(:county_details)).to eq({ county.std_fips_code => county })
    end

    it 'redirects to root_path when state is not found' do
      get :county, params: { state_symbol: 'INVALID_STATE', std_fips_code: '' }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("State 'INVALID_STATE' not found.")
    end

    it 'redirects to root_path when county is not found' do
      create(:state, symbol: 'CA', fips_code: '123')
      get :county, params: { state_symbol: 'CA', std_fips_code: 'INVALID_CODE' }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("County with code 'INVALID_CODE' not found for CA")
    end
  end
end
