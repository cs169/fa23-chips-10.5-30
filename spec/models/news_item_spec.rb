# frozen_string_literal: true
require 'rails_helper'
require 'spec_helper'

describe NewsItem do
  describe '.find_for' do
    it 'finds a news item for a given representative id' do
      representative = Representative.create
      news_item = NewsItem.create(representative: representative, title: 'Sample Title', link: 'http://example.com')
      found_news_item = NewsItem.find_for(representative.id)
      expect(found_news_item).to eq(news_item)
    end
  end
end