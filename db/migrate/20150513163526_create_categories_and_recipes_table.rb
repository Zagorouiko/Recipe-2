class CreateCategoriesAndRecipesTable < ActiveRecord::Migration
  def change
    create_table(:categories) do |t|
      t.column(:description, :string)
      t.timestamps null: false
    end

    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:instruction, :string)
      t.timestamps null: false
    end

    create_table(:categories_recipes, id: false) do |t|
      t.belongs_to :categories, index: true
      t.belongs_to :recipes, index: true
    end
  end
end
