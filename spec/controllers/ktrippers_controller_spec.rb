# encoding: utf-8
require 'spec_helper'

describe KtrippersController do

  describe 'GET ktrippers' do
  
    it 'works' do
      get :index
      response.should be_success
    end

    it 'returns an empty json when there is no parameter' do
      get :index
      ktrippers_json = ActiveSupport::JSON.decode(response.body)
      ktrippers_json.should == {}
    end

    it 'returns the ktripper who is in the place passed on parameter' do
      place = Factory.create(:place, :name=>'lugar legalzão', :latitude=>10, :longitude=>12)
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)

      get :index, :place_id=>place.id
      ktrippers_json = ActiveSupport::JSON.decode(response.body)
      ktrippers_json.should == [{'name'=>'aaa', 'place'=>'lugar legalzão'}]
    end

  end
  
end