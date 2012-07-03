# encoding: utf-8
require 'spec_helper'

describe UsersController do

  describe 'PUT drop' do
    
    it 'works' do
      put :drop
      response.should be_success
    end

  end
  
  describe 'PUT pickup' do

    it 'works' do
      put :pickup
      response.should be_success
    end

  end

end
