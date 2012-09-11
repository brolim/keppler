# encoding: utf-8
require 'spec_helper'
require 'date'

describe KtrippersController do

  describe 'GET ktrippers' do
  
    it 'works' do
      get :index
      response.should be_success
    end

    it 'returns an empty json when there is no parameter' do
      get :index
      ktrippers_json = ActiveSupport::JSON.decode(response.body)
      ktrippers_json.should == []
    end

    it 'returns the ktripper who is in the place passed on parameter' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place,
                                :img=>'/the/img.jpg')

      get :index, :latitude=>10.002, :longitude=>12.002
      ktrippers_json = ActiveSupport::JSON.decode(response.body)
      ktrippers_json.should == [{'name'=>'aaa', 'place'=>'lugar legalzão', 
                                  '_id'=>ktripper.id.to_s, 'img'=>'/the/img.jpg'}]
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

    xit 'rejects a drop on a already dropped tripper'
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
      json = ActiveSupport::JSON.decode(response.body)
      json.should == {'success'=>false}
    end

    it 'returns success on json' do
      user = Factory.create(:user)
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)
      put :pickup , :id => ktripper.id, :user => user.id
      json = ActiveSupport::JSON.decode(response.body)
      json.should == {'success'=>true}
    end

    xit 'validates users location against the place'

  end

  describe 'GET History' do

    it 'works' do
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      get :history , :id => ktripper.id
      response.should be_success
    end

    it 'returns last place dropped' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      put :drop, :id=>ktripper.id, :where => place.id
      get :history , :id => ktripper.id
      json = ActiveSupport::JSON.decode(response.body)
      json.should == [{'name'=>place.name, 'elapsed_days'=>0}]
    end

    it 'returns all places dropped' do
      place1 = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      place2 = Factory.create(:place, :name=>'outro lugar legalzão', :coordinates=>[11,13])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      put :drop, :id=>ktripper.id, :where => place1.id
      put :drop, :id=>ktripper.id, :where => place2.id
      get :history , :id => ktripper.id
      json = ActiveSupport::JSON.decode(response.body)
      json.should == [{'name'=>place1.name, 'elapsed_days'=>0},
                      {'name'=>place2.name, 'elapsed_days'=>0}]
    end

    it 'returns the number of days elapsed' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      ktripper.drop place
      ktripper.drop place
      ktripper.drop place
      ktripper.reload
      ktripper.visits[0].date = Time.new - 1*24*60*60
      ktripper.visits[1].date = Time.new - 2*24*60*60
      ktripper.visits[2].date = Time.new - 3*24*60*60
      ktripper.save
      get :history , :id => ktripper.id
      json = ActiveSupport::JSON.decode(response.body)
      json.should == [{'name'=>place.name, 'elapsed_days'=>1}, 
                      {'name'=>place.name, 'elapsed_days'=>2}, 
                      {'name'=>place.name, 'elapsed_days'=>3}]
    end

  end
  
end