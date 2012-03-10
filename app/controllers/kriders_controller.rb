# encoding: utf-8
require 'pp'
require 'net/http'

class KridersController < ApplicationController
  def index
  	render :json=> [{:name=>"Antônio Terráqueo", :place=>'asa sul'},
        				    {:name=>"José Luz", :place=>'asa norte'},
        				    {:name=>"Raio do Sul", :place=>'lago sul'},
          				  {:name=>"Maria da Lua", :place=>'lago norte'},
          				  {:name=>"Saturno Escocês", :place=>'guará'},
          				  {:name=>"Bolo Espacial", :place=>'taguá'},
          				  {:name=>"Space Cake", :place=>'sobral city'},
          				  {:name=>"João Doidão", :place=>'park away'},
          				  {:name=>"Krider do Fabs", :place=>'águas claras'}]
  end

  def venues_auth
  end

  def venues
    #url to get authentication code for foursquare users
    #"https://foursquare.com/oauth2/authenticate
    #   ?client_id=3MRAFEKRVI0SG22ITWHZCPXKSN0GUTRXHUAOIMY24O1NDGAU
    #   &response_type=code
    #   &redirect_uri=http://keppler.herokuapp.com/"

    #code for brolim: code=BN3KXZ1GQUSQ12KMHQFGOH0ZS2YS52B4TTQDZNBVSXV3CFZU
    #"https://foursquare.com/oauth2/access_token
    #   ?client_id=3MRAFEKRVI0SG22ITWHZCPXKSN0GUTRXHUAOIMY24O1NDGAU
    #   &client_secret=ZPHGYMPOFZIFNOEYWFUJDF5Y4MI03FOPCDMGBBPGSWSPG5O2
    #   &grant_type=authorization_code
    #   &redirect_uri=http://keppler.herokuapp.com/
    #   &code=BN3KXZ1GQUSQ12KMHQFGOH0ZS2YS52B4TTQDZNBVSXV3CFZU

    url = URI.parse("https://api.foursquare.com/v2/venues/search?ll=40.7,-74")
    req = Net::HTTP::Get.new(url.path)

    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end

    render :json=>res.body
  end
end