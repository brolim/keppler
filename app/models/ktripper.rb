# encoding: utf-8
class Ktripper
  include Mongoid::Document

  field :name, :default=>nil
  belongs_to :place
  belongs_to :user
  embeds_many :visits
  
  scope :who_are_in, ->(place_id) {  where('place_id'=>place_id) }
end