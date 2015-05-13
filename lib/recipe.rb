class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  validates(:name, {:presence => true, :length => {:maximum => 50}})
  validates(:instruction, {:presence => true})
end
