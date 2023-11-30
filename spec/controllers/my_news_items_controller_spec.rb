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


  describe 'POST create' do
    let(:representative) { create(:representative) }
    context 'with valid params' do
      it 'successfully creates object' do
        @news_item = NewsItem.create(title: "Title", representative_id: representative.id, link:'', id: '')
        expect(@news_item).to be_valid
        expect(@news_item.persisted?).to be_truthy
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before {
        @news_item = create(:news_item)
      }

      it 'successfully updates news_item' do
        @news_item.update(title: "New Title")
        expect(@news_item.title).to eq("New Title")
      end
    end

    context 'with invalid params' do
      before {
        @news_item = create(:news_item, title: "Sample News")
      }
      it 'does not update the news_item' do
        expect(@news_item.title).to eq("Sample News")
        expect { @news_item.update(title: nil) }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
  
  describe '#destroy' do
    before {
      @news_item = create(:news_item, title: "Sample News")
    }
    it 'destroys a news item' do
      @news_item.destroy
      expect(@news_item).to be_nil
    end
  end


  describe '#news_items_parameters' do
    it 'ensures news item has correct parameters' do
      params = ActionController::Parameters.new(news_item: { title: 'Test', description: 'Test', link: 'Test',
representative_id: 3, issue: 'Equal Pay' })
      controller.params = params
      result = controller.send(:news_item_params)
      expect(result).to eq(params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue))
    end
  end
end
