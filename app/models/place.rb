# encoding: utf-8
class Place
  include Mongoid::Document

  field :name, :default=>nil
  field :latitude, :default=>nil
  field :longitude, :default=>nil
  field :radius, :default=>nil
  has_many :ktrippers
end