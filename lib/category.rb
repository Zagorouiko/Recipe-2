class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:description, {:presence => true, :length => {:maximum => 50}})
end
