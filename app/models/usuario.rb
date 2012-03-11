class Usuario
  include Mongoid::Document

  field :email, :default=>nil

  embeds_one :foursquare
end