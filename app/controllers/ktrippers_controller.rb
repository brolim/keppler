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
    begin
      ktripper = Ktripper.find params[:id]
      where = Place.find params[:where]
      ktripper.place = where
      ktripper.visits << Visit.new(:place=>where)
      ktripper.user = nil
      ktripper.save
    rescue
    end
    render :json=>{}
  end

  def pickup
    begin
      ktripper = Ktripper.find params[:id]
      user = User.find params[:user]
      ktripper.user = user
      ktripper.place = nil
      ktripper.save
    rescue
    end
    render :json=>{}
  end

  def history
    ktripper = Ktripper.find params[:id]
    list = []
    ktripper.visits.each do |v|
      list << {'name'=>v.place.name}
    end
    render :json=>list
  end
end