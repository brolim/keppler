# encoding: utf-8

class Place
  include Mongoid::Document

  include Geocoder::Model::Mongoid

  field :name, :default=>nil
  field :radius, :default=>nil
  field :coordinates, :type=>Array

  reverse_geocoded_by :coordinates

  has_many :ktrippers

  def self.nearby_places(coords, radius_in_km)
    temp_place = Place.new ({:coordinates=>coords})
    nearbys = []
    Place.all.each do |place|
      distance_to = temp_place.distance_to(place, :km)
      nearbys << place if distance_to<radius_in_km.to_f
    end
    nearbys.sort {|p1, p2| p1.distance_to(p2,:km) }
  end

end