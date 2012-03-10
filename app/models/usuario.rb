class Usuario
  include Mongoid::Document

  field :email, :default=>nil
end