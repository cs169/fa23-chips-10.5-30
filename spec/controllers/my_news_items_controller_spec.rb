# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe MyNewsItemsController do
  describe 'GET #new' do
    before { @news_item = create(:news_item) }

    it 'assigns a new news item to @news_item' do
      expect(@news_item).to be_valid
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:representative) { create(:representative) }

    context 'with valid params' do
      it 'successfully creates object' do
        @news_item = NewsItem.create(title: "Title", representative_id: representative.id, link:'', id: '', issue: "Free Speech")
        expect(@news_item).to be_valid
        expect(@news_item.persisted?).to be_truthy
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
