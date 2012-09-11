require 'date'
class KtrippersController < ApplicationController

  def index
    ktrippers = []

    if not params[:latitude].nil? or not params[:longitude].nil?
      coordinates = [params[:latitude].to_f, params[:longitude].to_f]
      Place.nearby_places(coordinates, 2).each do |place|
        ktrippers += Ktripper.who_are_in(place._id).map{|kt| {:name=>kt.name, 
                        :place=>kt.place.name, :_id=>kt.id, :img=>kt.img} }
      end
    end

    render :json=>ktrippers.to_json
  end

  def drop
    begin
      ktripper = Ktripper.find params[:id]
      where = Place.find params[:where]
      ktripper.drop where
    rescue
    end
    render :json=>{}
  end

  def pickup
    begin
      ktripper = Ktripper.find params[:id]
      user = User.find params[:user]
      ktripper.pickup user
      render :json=>{'success'=>true}
    rescue
      render :json=>{'success'=>false}
    end
  end

  def history
    ktripper = Ktripper.find params[:id]
    list = []
    now = Time.new
    ktripper.visits.each do |v|
      list << {'name'=>v.place.name, 'elapsed_days'=>Time.at(now.to_date - v.date.to_date).to_i}
      # list << {'name'=>v.place.name}
    end
    render :json=>list
  end
end