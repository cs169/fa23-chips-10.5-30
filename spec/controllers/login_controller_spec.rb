# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let(:user_info) do
    {
      'provider' => 'google_oauth2',
      'uid' => '123',
      'info' => {
        'first_name' => 'John',
        'last_name' => 'Doe',
        'email' => 'john@example.com'
      }
    }
  end

  describe '#login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe '#google_oauth2' do
    it 'calls create_session with :create_google_user' do
      expect(controller).to receive(:create_session).with(:create_google_user)
      get :google_oauth2
    end
  end

  describe '#github' do
    it 'calls create_session with :create_github_user' do
      expect(controller).to receive(:create_session).with(:create_github_user)
      get :github
    end
  end

  describe '#logout' do
    it 'logs out the user and redirects to root_path' do
      session[:current_user_id] = 1
      delete :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('You have successfully logged out.')
    end
  end

  describe '#create_session' do
    it 'finds or creates a user and sets the current_user_id in the session' do
      expect(controller).to receive(:find_or_create_user).and_return(User.new(id: 1))
      post :create_session, params: { create_if_not_exists: :create_google_user, user_info: user_info }
      expect(session[:current_user_id]).to eq(1)
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#find_or_create_user' do
    it 'finds an existing user or creates a new user' do
      existing_user = create(:user, provider: 'google_oauth2', uid: '123')
      expect(controller.find_or_create_user(user_info, :create_google_user)).to eq(existing_user)
    end
  end
end
