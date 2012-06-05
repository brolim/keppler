# encoding: utf-8
require 'spec_helper'

describe PlacesController do

  describe 'GET index' do
  
    it 'works' do
      get :index
      response.should be_success
    end

    describe 'missing parameters' do

      it 'returns an empty json when the two parameters are missing' do
        get :index
        ktrippers_json = ActiveSupport::JSON.decode(response.body)
        ktrippers_json.should == {}
      end

      it 'returns an empty json when coordinates is empty' do
        get :index, :coordinates=>[], :within=>'3'
        ktrippers_json = ActiveSupport::JSON.decode(response.body)
        ktrippers_json.should == {}
      end

      it 'returns an empty json when longitude is missing' do
        get :index, :coordinates=>[1], :within=>'3'
        ktrippers_json = ActiveSupport::JSON.decode(response.body)
        ktrippers_json.should == {}
      end

      it 'returns an empty json when within is missing' do
        get :index, :coordinates=>[3,1]
        ktrippers_json = ActiveSupport::JSON.decode(response.body)
        ktrippers_json.should == {}
      end

    end

    it 'returns places that correspond to the parameters coordinates' do
      Factory.create(:place, :name=>'igual', :coordinates=>[40.71, 100.23])
      
      get :index, :coordinates=>[40.71, 100.23], :within=>20
      places_json = ActiveSupport::JSON.decode(response.body)
      places_json.map{|place| place['name']}.should == ['igual']
    end

    it 'returns nearby places respecting "within" parameter in kilometers' do
      Factory.create(:place, :name=>'pertinho', :coordinates=>[10.5, 100.23])
      Factory.create(:place, :name=>'pertão', :coordinates=>[10.5, 100.24])
      Factory.create(:place, :name=>'longinho', :coordinates=>[100.23, 10.5])
      Factory.create(:place, :name=>'lonjão', :coordinates=>[100.24, 10.5])
      
      get :index, :coordinates=>[10.5, 100.24], :within=>3
      places_json = ActiveSupport::JSON.decode(response.body)
      places_json.map{|place| place['name']}.should == ['pertão','pertinho']
    end

  end
  
end