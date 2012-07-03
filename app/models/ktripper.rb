# encoding: utf-8
class Ktripper
  include Mongoid::Document

  field :name, :default=>nil
  belongs_to :place
  has_and_belongs_to_many :users
  
  scope :who_are_in, ->(place_id) {  where('place_id'=>place_id) }
end