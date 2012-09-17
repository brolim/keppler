# encoding: utf-8
require 'date'

FactoryGirl.define do

  factory :ktripper do
    name "ktripper's name"
  end

  factory :place do
    name "place's name"
  end

  factory :user do
    name "user's name"
  end

  factory :visit do
  end

  factory :gamefyvote, class: GamefyVote do
    email 'dummy@server.com'
    option [1,2] 
    date Time.new
  end
end