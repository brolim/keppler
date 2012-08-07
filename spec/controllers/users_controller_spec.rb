# encoding: utf-8
require 'spec_helper'

describe UsersController do

  describe 'PUT users' do

    describe 'login' do
      
        it 'works' do
          user = Factory.create(:user, :name=>'Bruce Wayne', 
                      :email=>'bruce@wayne.co', 
                      :pass=>'123456')
          put :signin, :email=>user.email, :pass => user.pass
          response.should be_success
        end

        it 'return success data' do
          user = Factory.create(:user, :name=>'Bruce Wayne', 
                      :email=>'bruce@wayne.co', 
                      :pass=>'123456')
          put :signin, :email=>user.email, :pass => user.pass
          json = ActiveSupport::JSON.decode(response.body)
          json.should == {'success'=>'true', 'name'=>user.name, 'id'=>user.id.to_s}
        end

        it 'rejects with wrong password' do
          user = Factory.create(:user, :name=>'Bruce Wayne', 
                      :email=>'bruce@wayne.co', 
                      :pass=>'123456')
          put :signin, :email=>user.email, :pass => '654321'
          json = ActiveSupport::JSON.decode(response.body)
          json.should == {'success'=>'false'}
        end

        it 'rejects with wrong email' do
          user = Factory.create(:user, :name=>'Bruce Wayne', 
                      :email=>'bruce@wayne.co', 
                      :pass=>'123456')
          put :signin, :email=>'clark@kent.com', :pass => '654321'
          json = ActiveSupport::JSON.decode(response.body)
          json.should == {'success'=>'false'}
        end
    end

  end

end
