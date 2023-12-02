# frozen_string_literal: true

require 'rails_helper'

describe NewsItemsController do
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative_id: representative.id, issue: "Free Speech") }

  describe 'GET #index' do
    it 'assigns @news_items and renders the index template' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq([news_item])
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns @news_item and renders the show template' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
      expect(response).to render_template('show')
    end
  end
end
