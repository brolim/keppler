class KtrippersController < ApplicationController

  def index
    ktrippers = {}

    if not params[:latitude].nil? or not params[:longitude].nil?
      ktrippers = []
      coordinates = [params[:latitude].to_f, params[:longitude].to_f]
      Place.nearby_places(coordinates, 2).each do |place|
        ktrippers += Ktripper.who_are_in(place._id).map{|kt| {:name=>kt.name, :place=>kt.place.name} }
      end
    end

    render :json=>ktrippers.to_json
  end

end