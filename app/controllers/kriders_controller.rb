# encoding: utf-8
require 'pp'

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
end