# encoding: utf-8
class Krider
  include Mongoid::Document

  field :name, :default=>'krider malucão'
  field :place, :default=>'lugar doidão!'
end