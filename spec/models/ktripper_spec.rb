# encoding: utf-8
require 'spec_helper'
require 'date'

describe Ktripper do

  describe 'drop' do
  
    it 'places tripper in the informed location' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa')
      ktripper.drop place
      ktripper.place.should == place
    end

    it 'removes user from ktripper' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :user=> Factory.create(:user))
      ktripper.drop place
      ktripper.user.should be_nil
    end

    it 'creates a visit history' do
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa')
      ktripper.drop place
      ktripper.visits.length.should == 1
      ktripper.visits[0].place.should == place
      ktripper.visits[0].date.should == Time.at(Time.new.to_i)
    end

	end

  describe 'pickup' do
    
    it 'removes tripper from the location' do
      user = Factory.create(:user)
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)
      ktripper.pickup user
      ktripper.place.should be_nil
    end

    it 'places tripper with the user' do
      user = Factory.create(:user)
      place = Factory.create(:place, :name=>'lugar legalzão', :coordinates=>[10,12])
      ktripper = Factory.create(:ktripper, :name=>'aaa', :place=>place)
      ktripper.pickup user
      ktripper.user.should == user
    end
  end
end
