# encoding: utf-8
class Ktripper
  include Mongoid::Document

  scope :who_are_in, ->(place_id) {  where('place_id'=>place_id) }

  field :name, :default=>nil
  belongs_to :place
end