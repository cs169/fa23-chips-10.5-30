# frozen_string_literal: true

require 'rails_helper'

describe EventsController do
  describe 'GET #index' do
    before do
      @state = create(:state)
      @county = create(:county, state_id: @state.id)
      @event = Event.create(county_id: @county.id, name: 'Test Name', start_time: Time.zone.local(2024, 11, 24),
                            end_time: Time.zone.local(2024, 12, 1))
    end

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'assigns all events when no filter is applied' do
      get :index
      expect(assigns(:events)).to eq([@event])
    end

    it 'filters events by state-only' do
      get :index, params: { 'filter-by' => 'state-only', 'state' => @state.symbol }

      expect(assigns(:events)).to eq([@event])
    end

    it 'filters events by county within a state' do
      get :index, params: { 'filter-by' => 'county', 'state' => @state.symbol, 'county' => @county.fips_code }

      expect(assigns(:events)).to eq([@event])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      county = create(:county)
      event = create(:event, county_id: county.id)
      get :show, params: { id: event.id }
      expect(response).to have_http_status(:ok)
    end

    it 'assigns the requested event to @event' do
      county = create(:county)
      event = create(:event, county_id: county.id)
      get :show, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end
end
