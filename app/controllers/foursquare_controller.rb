# encoding: utf-8
require 'pp'
require 'net/http'

class FoursquareController < ApplicationController
  def auth
    uri = "https://foursquare.com/oauth2/authenticate"
    uri += "?client_id=#{Foursquare::CLIENT_ID}"
    uri += "&response_type=code"
    uri += "&redirect_uri=#{Foursquare::REDIRECT_URI}"

    url = URI.parse(uri)
    req = Net::HTTP::Get.new(url.path)

    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  end

  def access_token

  end

  def result
    fs = Foursquare.new

    a = "fora"
    unless params[:code].nil?
      a = "dentro"
      fs.code = params[:code]
    end

    render :text=>"---- #{a} ----> code: #{fs.code} ----> params: #{params}"
  end
end