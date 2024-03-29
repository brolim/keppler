# encoding: utf-8
require 'date'

class Ktripper
  include Mongoid::Document

  field :name, :default=>nil
  field :img, :default=>nil
  belongs_to :place
  belongs_to :user
  embeds_many :visits
  
  scope :who_are_in, ->(place_id) {  where('place_id'=>place_id) }

  def drop where
    self.place = where
    self.visits << Visit.new(:place=>where, :date=>Time.at(Time.new.to_i))
    self.user = nil
    self.save
  end

  def pickup who
    self.user = who
    self.place = nil
    self.save
  end
end