# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe MyNewsItemsController do
  describe 'GET #new' do
    before { @news_item = NewsItem.new }

    it 'assigns a new news item to @news_item' do
      expect(@news_item).to be_a_new(NewsItem)
    end

    it 'returns a successful response' do
      get :new
      expect(response).to have_http_status(:ok)
    end

    it 'assigns the requested item to @new_item' do
      expect(assigns(:news_item)).to eq(@news_item)
    end
  end

  describe 'POST #create' do
    let(:representative) { create(:representative) }

    context 'with valid params' do
      it 'successfully creates object' do
        news_item_params = { title: 'Title', representative_id: representative.id, link: '', id: '' }
        post :create, params: { news_item: news_item_params }
        expect(assigns(:news_item)).to be_persisted
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        @news_item = create(:news_item)
      end

      it 'successfully updates news_item' do
        put :update, params: { id: @news_item.id, news_item: { title: 'New Title' } }
        @news_item.reload
        expect(@news_item.title).to eq('New Title')
      end
    end

    context 'with invalid params' do
      before do
        @news_item = create(:news_item, title: 'Sample News')
      end

      it 'does not update the news_item' do
        put :update, params: { id: @news_item.id, news_item: { title: nil } }
        @news_item.reload
        expect(@news_item.title).to eq('Sample News')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @news_item = create(:news_item, title: 'Sample News')
    end

    it 'destroys a news item' do
      delete :destroy, params: { id: @news_item.id }
      expect { @news_item.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#news_items_parameters' do
    it 'ensures news item has correct parameters' do
      params = ActionController::Parameters.new(news_item: { title: 'Test', description: 'Test', link: 'Test',
                                                             representative_id: 3, issue: 'Equal Pay' })
      controller.params = params
      result = controller.send(:news_item_params)
      expected_params = params.require(:news_item).permit(:title, :description, :link, :representative_id, :issue)
      expect(result).to eq(expected_params)
    end
  end
end
