class KtrippersController < ApplicationController

  def index
    ktrippers = {}

    unless params[:place_id].nil?
      ktrippers = Ktripper.who_are_in(params[:place_id]).map {|kt| {:name=>kt.name, :place=>kt.place.name} }
    end

    render :json=>ktrippers.to_json
  end

end