require 'rails_helper'
require 'spec_helper'

describe MyEventsController do
  describe '.new' do
    it 'successfully creates a new event' do
      @county = County.create
      @event = Event.new(county: @county,:start_time => Time.new(2023, 11, 24), :end_time=> Time.new(2023, 12, 1))
      expect(@event).to be_valid
    end
  end

  describe '.create' do
    it 'successfully creates a new event' do
      @county = County.create
      @event = Event.create(county: @county,:start_time => Time.new(2023, 11, 24), :end_time=> Time.new(2023, 12, 1))
      expect(flash[:notice]).to eq('Event was successfully created.')
    end
  end

  describe '.update' do
    it 'unsuccessfully updates an event' do
      @county = County.create
      @event = Event.update(county: @county,:start_time => Time.new(2023, 11, 26), :end_time=> Time.new(2023, 12, 1))
      expect(flash[:notice]).to eq('Event was successfully updated.')
    end
  end
end