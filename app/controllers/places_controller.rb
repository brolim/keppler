class PlacesController < ApplicationController

  def index
    if params['coordinates'].blank? or params['coordinates'].size!=2
      missing_parameters = true
    elsif params['within'].blank?
      missing_parameters = true
    end

    if missing_parameters
      render :json=>{}
    else
      nearby_places = Place.nearby_places(params['coordinates'], params['within'].to_f)
      render :json=>nearby_places
    end
  end

end