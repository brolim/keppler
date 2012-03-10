require 'pp'
class UsuariosController < ApplicationController
  def index
  	@usuarios = Usuario.all
  end

  def create
    Usuario.new(:email=>params[:usuario][:email]).save! unless params[:usuario][:email].nil?
    redirect_to k_riders_path
  end
end