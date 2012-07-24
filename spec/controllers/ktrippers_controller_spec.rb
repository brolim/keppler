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
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)

      get :index, :latitude=>10.002, :longitude=>12.002
      ktrippers_json = ActiveSupport::JSON.decode(response.body)
      ktrippers_json.should == [{'name'=>'aaa', 'place'=>'lugar legalzão'}]
    end

  end

  describe 'PUT drop' do
    
    it 'works' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa')
      put :drop, :id=>ktripper.id, :where => place
      response.should be_success
    end

    it 'places tripper in the informed location' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa')
      put :drop, :id=>ktripper.id, :where => place
      ktripper.reload
      place.id.should == ktripper.place.id
    end

    it 'removes user from ktripper' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      put :drop, :id=>ktripper.id, :where => place
      ktripper.reload
      ktripper.user.should be_nil
    end

    xit 'doesnt fail for an invalid place'
    xit 'doesnt fail for an invalid user'

  end
  
  describe 'PUT pickup' do

    xit 'works' do
      put :pickup 
      response.should be_success
    end

  end
  
end