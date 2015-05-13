require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/') do
  @categories = Category.all
  erb(:index)
end

post('/') do
  description = params.fetch('description')
  Category.create({:description => description})
  @categories = Category.all
  erb(:index)
end

get('/category/:id/recipes') do
  id = params.fetch('id').to_i
  @category = Category.find(id)
  @recipes = @category.recipes()
  erb(:recipes)
end

delete('/category/:id') do
  id = params.fetch('id').to_i
  category = Category.find(id)
  category.destroy()
  @categories = Category.all
  erb(:index)
end

get('/category/:category_id/recipe/:id') do
  @id = params.fetch('id').to_i
  category_id = params.fetch('category_id').to_i
  @category = Category.find(category_id)
  @recipes = @category.recipes()
  erb(:recipes)
end

get('/recipes/new') do
  @categories = Category.all
  erb(:recipe_form)
end

post('/recipes') do
  name = params.fetch('name')
  instruction = params.fetch('instruction')
  category_id = params.fetch('category_id').to_i
  @category = Category.find(category_id)
  new_recipe = Recipe.create({:name => name, :instruction => instruction})
  @category.recipes.push(new_recipe)
  @recipes = @category.recipes()
  erb(:recipes)
end
