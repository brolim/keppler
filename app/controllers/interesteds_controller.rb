require 'pp'

class InterestedsController < ApplicationController
  def index
  	@interesteds = Interesteds.all
  end

  def create
    Interesteds.new(:email=>params[:usuario][:email]).save! unless params[:usuario][:email].nil?
    redirect_to root_path(:obrigado=>'k_rider')
  end
end