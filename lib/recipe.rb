class Recipe < ActiveRecord::Base
  validates(:name, {:presence => true, :length => {:maximum => 50}})
  validates(:instruction, {:presence => true})
  before_save(:capitalize_name)
  has_and_belongs_to_many(:categories)

  private

  define_method(:capitalize_name) do
    self.name=(name().capitalize())
  end

end
