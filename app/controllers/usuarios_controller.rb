require 'pp'

class UsuariosController < ApplicationController
  def index
  	@usuarios = Usuario.all
  end

  def create
    Usuario.new(:email=>params[:usuario][:email]).save! unless params[:usuario][:email].nil?
    redirect_to root_path(:obrigado=>'k_rider')
  end
end