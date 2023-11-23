# frozen_string_literal: true
require 'rails_helper'
require 'spec_helper'

describe User do
  describe '#name' do
    it 'returns the full name of the user' do
      user = User.new(first_name: 'John', last_name: 'Doe')
      expect(user.name).to eq('John Doe')
    end
  end

  describe '#auth_provider' do
    it 'returns the authentication provider name' do
      user = User.new(provider: 'google_oauth2')
      expect(user.auth_provider).to eq('Google')
    end
  end

  describe '.find_google_user' do
    it 'finds a user by Google UID' do
      user = User.create(provider: :google_oauth2, uid: 'google_uid')
      found_user = User.find_google_user('google_uid')
      expect(found_user).to eq(user)
    end
  end

  describe '.find_github_user' do
    it 'finds a user by GitHub UID' do
      user = User.create(provider: :github, uid: 'github_uid')
      found_user = User.find_github_user('github_uid')
      expect(found_user).to eq(user)
    end
  end
end
