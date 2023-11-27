# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  # political_party
  attr_accessor :political_party
  # photo
  attr_accessor :photo
  # address
  attr_accessor :address

  def show
    @representative = Representative.find(params[:id])
  end

    
  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      # Find or create a representative based on ocdid
      rep = Representative.find_or_create_by(ocdid: ocdid_temp) do |r|
        r.name = official.name
        r.title = title_temp
        r.political_party = official.party
        r.photo = official.photo_rul
        r.address  = official.address.to_s
        Rails.logger.info("REP: ", rep)
      end
      rep.save

      reps.push(rep)
    end
    
    unique_reps = reps.uniq { |element| element }
    unique_reps
  end
end
