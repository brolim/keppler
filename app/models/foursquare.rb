class Foursquare
  include Mongoid::Document

  CLIENT_ID = "3MRAFEKRVI0SG22ITWHZCPXKSN0GUTRXHUAOIMY24O1NDGAU"
  REDIRECT_URI = "http://keppler.herokuapp.com/foursquare/result"


  field :code, :default=>nil
end