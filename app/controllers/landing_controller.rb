class LandingController < ApplicationController
  def index
  	@usuarios = Usuario.all
  end
end