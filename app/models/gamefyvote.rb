require 'date'

class GamefyVote
  include Mongoid::Document
  field :email, :default=>nil
  field :option, :default=>nil
  field :vote, :default=>nil
  field :date, :default=>Time.new
end