# encoding: utf-8
require 'spec_helper'

describe GeolocationsController do

  describe 'GET ktrippers' do
  
    it 'works' do
      get :ktrippers
      response.status.should == 200
    end

  end
  
end