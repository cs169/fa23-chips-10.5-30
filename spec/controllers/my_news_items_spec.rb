require 'rails_helper'
require 'spec_helper'

describe MyNewsItemsController do
  describe '.create' do
    it 'successfully creates a news item' do
      representative = Representative.create
      news_item = NewsItem.create(representative: representative, title: 'Test', link: 'http://example.com')
      expect(flash[:error]).to eq('News item was successfully created.')
    end
    it 'unsuccessfully creates a new item' do
      news_item = NewsItem.create(representative: nil, title: nil, link: nil)
      expect(flash[:notice]).to eq('An error occurred when creating the news item.')
    end
  end

  describe '.update' do
    it 'successfully updates a new item' do
      representative = Representative.create
      news_item = NewsItem.update(representative: representative, title: 'Update', link: 'http://example.com')
      expect(flash[:error]).to eq('News item was successfully updated.')
    end
  end
end