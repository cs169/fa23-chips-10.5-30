# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe MyNewsItemsController do
  describe 'GET new' do
    before { @news_item = NewsItem.new }

    it 'assigns a new news item to @news_item' do
      expect(@news_item).to be_a_new(NewsItem)
    end
  end

  describe 'POST create' do
    let(:representative) { create(:representative) }

    context 'with valid params' do
      it 'successfully creates object' do
        @news_item = NewsItem.create(title: 'Title', representative_id: representative.id, link: '', id: '')
        expect(@news_item).to be_valid
        expect(@new_item).to be_persisted
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        @news_item = create(:news_item)
      end

      it 'successfully updates news_item' do
        @news_item.update(title: 'New Title')
        expect(@news_item.title).to eq('New Title')
      end
    end

    context 'with invalid params' do
      before do
        @news_item = create(:news_item, title: 'Sample News')
      end

      it 'does not update the news_item' do
        expect(@news_item.title).to eq('Sample News')
        expect { @news_item.update(title: nil) }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
end
