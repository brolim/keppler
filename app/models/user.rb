# encoding: utf-8

class User
  include Mongoid::Document

  field :email, :default=>nil
  field :name, :default=>nil
  has_one :ktripper
end