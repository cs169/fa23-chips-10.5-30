# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show 
    @representative =  Representative.find_by(name: params[:representative_name])
  end 
end
