require 'pp'

class InterestedsController < ApplicationController
  def index
  	@interesteds = Interested.all
  end

  def create
    Interested.new(:email=>params[:interested][:email]).save! unless params[:interested][:email].nil?
    redirect_to root_path(:obrigado=>'k_rider')
  end
end