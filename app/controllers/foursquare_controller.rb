# encoding: utf-8
require 'pp'
require 'net/http'

class FoursquareController < ApplicationController
  def auth
    client_id = "3MRAFEKRVI0SG22ITWHZCPXKSN0GUTRXHUAOIMY24O1NDGAU"
    redirect_uri = "http://keppler.herokuapp.com/"

    uri = "https://foursquare.com/oauth2/authenticate"
    uri += "?client_id=#{client_id}"
    uri += "&response_type=code"
    uri += "&redirect_uri=http://keppler.herokuapp.com/"

    url = URI.parse(uri)
    req = Net::HTTP::Get.new(url.path)

    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end

    render :json=>res.body

  end

  def result
    render :text=>"---> #{params}"
  end
end