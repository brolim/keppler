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
      put :drop, :id=>ktripper.id, :where => place.id
      response.should be_success
    end

    it 'places tripper in the informed location' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa')
      put :drop, :id=>ktripper.id, :where => place.id
      ktripper.reload
      ktripper.place.should == place
    end

    it 'removes user from ktripper' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      put :drop, :id=>ktripper.id, :where => place.id
      ktripper.reload
      ktripper.user.should be_nil
    end

    it 'doesnt fail for an invalid place' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      put :drop, :id=>ktripper.id, :where => 123456
      ktripper.reload
      ktripper.place.should be_nil
      ktripper.user.should_not be_nil
    end

    xit 'validates place against the users location'

  end
  
  describe 'PUT pickup' do

    it 'works' do
      user = Factory.create(:user)
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)
      put :pickup , :id => ktripper.id, :user => user.id
      response.should be_success
    end

    it 'removes tripper from the location' do
      user = Factory.create(:user)
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)
      put :pickup , :id => ktripper.id, :user => user.id
      ktripper.reload
      ktripper.place.should be_nil
    end

    it 'places tripper with the user' do
      user = Factory.create(:user)
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)
      put :pickup , :id => ktripper.id, :user => user.id
      ktripper.reload
      ktripper.user.should == user
    end

    it 'doesnt fail for an invalid user' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)
      put :pickup , :id => ktripper.id, :user => 12345
      ktripper.reload
      ktripper.user.should be_nil
    end

    xit 'returns success on json'

    xit 'validates users location against the place'

  end
  
end