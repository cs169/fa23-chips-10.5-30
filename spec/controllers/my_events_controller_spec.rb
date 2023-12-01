# frozen_string_literal: true
require 'rails_helper'
require 'spec_helper'

describe MyEventsController do
  let(:user) { double(User) }

  before do
    allow(controller).to receive(:require_login!)
    # allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { event: attributes_for(:event) } }

    before do
      @state = create(:state)
      @county = create(:county, state_id: @state.id)
    end

    context 'with valid params' do
      it 'creates a new event' do
        @event = Event.create(name: 'Test', county_id: @county.id, start_time: Time.new(2024, 11, 24),
                              end_time: Time.new(2024, 12, 1))
        expect(@event).to be_valid
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { event: attributes_for(:event, name: nil) } }

      it 'does not create a new event' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Event, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event) }

    it 'renders the edit template' do
      get :edit, params: { id: event.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested event to @event' do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'PATCH #update' do
    let(:event) { create(:event) }
    let(:valid_params) { { id: event.id, event: { name: 'New Name' } } }

    context 'with valid params' do
      it 'updates the requested event' do
        patch :update, params: valid_params
        event.reload
        expect(event.name).to eq('New Name')
      end

      it 'redirects to events_path with a success notice' do
        patch :update, params: valid_params
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully updated.')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:event) { create(:event) }

    it 'destroys the requested event' do
      expect do
        delete :destroy, params: { id: event.id }
      end.to change(Event, :count).by(-1)
    end

    it 'redirects to events_url with a success notice' do
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to(events_url)
      expect(flash[:notice]).to eq('Event was successfully destroyed.')
    end
  end
end
