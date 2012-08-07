require 'pp'

class UsersController < ApplicationController

  def signin
  	user = User.where(:email=>params[:email]).first
  	if user and user.pass == params[:pass]
  		render :json=>{'success'=>'true','name'=>user.name, 'id'=>user.id}
  	else
  		render :json=>{'success'=>'false'}
  	end
  end

end