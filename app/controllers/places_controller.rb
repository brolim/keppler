class PlacesController < ApplicationController

  def index
    if params['latitude'].blank? or params['longitude'].blank?
      missing_parameters = true
    elsif params['within'].blank?
      missing_parameters = true
    end

    if missing_parameters
      render :json=>{}
    else
      coordinates = [params[:latitude].to_f, params[:longitude].to_f]
      nearby_places = Place.nearby_places(coordinates, params['within'].to_f)
      render :json=>nearby_places
    end
  end

end