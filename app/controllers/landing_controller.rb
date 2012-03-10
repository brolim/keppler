require 'pp'

class LandingController < ApplicationController
  def landing
    render :layout=>false
  end
end