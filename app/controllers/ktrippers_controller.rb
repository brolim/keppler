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

  def drop
    ktripper = Ktripper.find params[:id]
    where = Place.find params[:where]
    ktripper.place = where
    ktripper.user = nil
    ktripper.save
    render :json=>{}
  end
end