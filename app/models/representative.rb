# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def show
    @representative = Representative.find(params[:id])
  end

    
  def self.civic_api_to_representative_params(rep_info)
    reps = []
    encountered_names = Set.new

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      # Check if the name has been encountered before
      next if encountered_names.include?(official.name)

      # Find or create a representative based on ocdid
      rep = Representative.find_or_create_by(ocdid: ocdid_temp) do |r|
        r.name = official.name
        r.title = title_temp
      end

      # Add the name to the encountered set
      encountered_names.add(official.name)

      reps.push(rep)
    end
    # Rails.logger.info(reps)
    unique_reps = reps.uniq { |element| element }
    unique_reps
  end
end
