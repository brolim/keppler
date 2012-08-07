# encoding: utf-8
class Visit
  include Mongoid::Document

  field :date, :default=>nil
  belongs_to :place
  embedded_in :ktripper
end