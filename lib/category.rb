class Category < ActiveRecord::Base
  validates(:description, {:presence => true, :length => {:maximum => 50}})
  before_save(:capitalize_description)
  has_and_belongs_to_many(:recipes)

  private

  define_method(:capitalize_description) do
    self.description=(description().capitalize())
  end

end
