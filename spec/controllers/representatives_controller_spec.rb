# frozen_string_literal: true

require 'rails_helper'

describe RepresentativesController do
  describe 'GET #index' do
    it 'assigns all representatives to @representatives' do
      representative1 = create(:representative)
      representative2 = create(:representative)
      get :index
      expect(assigns(:representatives)).to eq([representative1, representative2])
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested representative to @representative' do
      representative = create(:representative)
      get :show, params: { representative_name: representative.name }
      expect(assigns(:representative)).to eq(representative)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      representative = create(:representative)
      get :show, params: { representative_name: representative.name }
      expect(response).to render_template(:show)
    end

    it 'handles not found representative' do
      get :show, params: { representative_name: 'nonexistent' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
