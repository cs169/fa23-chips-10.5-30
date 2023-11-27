# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  #table has:
  #name
  #ocdid
  #title
  #political_party
  #address
  #photo

  def show
    @representative = Representative.find(params[:id])
  end

  def self.civic_api_to_representative_params(rep_info)
    reps = []
  
    rep_info.officials.each_with_index do |official, index|
      office_info = find_office_for_official(rep_info.offices, index)
  
      # If an office is found for the current official
      if office_info
        title_temp = office_info.name
        ocdid_temp = office_info.division_id
  
        # Find or initialize a representative based on ocdid
        rep = Representative.find_or_initialize_by(ocdid: ocdid_temp) do |r|
          r.name = official.name
          r.title = title_temp
          r.ocdid = ocdid_temp
          r.political_party = official.party
          r.photo = official.photo_url
          r.address = official.address.to_s
        end
  
        # Save the representative
        rep.save!
  
        reps.push(rep)
      end
    end
  
    unique_reps = reps.uniq { |element| element }
    unique_reps
  end
  
  # Helper method to find the office for a given official index
  def self.find_office_for_official(offices, official_index)
    offices.find { |office| office.official_indices.include?(official_index) }
  end
  

    
  def self.civic_api_to_representative_params_original(rep_info)
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
      rep = Representative.find_or_initialize_by(ocdid: ocdid_temp) do |r|
        r.name = official.name
        r.title = title_temp
        r.political_party = official.party
        r.photo = official.photo_rul
        r.address  = official.address.to_s
      end
      rep.save!

      reps.push(rep)
    end
    
    unique_reps = reps.uniq { |element| element }
    unique_reps
  end
end
