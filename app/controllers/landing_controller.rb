require 'pp'
class LandingController < ApplicationController
  def index
  	@usuarios = Usuario.all
  end

  def register_email
    Usuario.new(:email=>params[:email]).save! unless params[:email].nil?
  	@usuarios = Usuario.all
  	render :index
  end
end