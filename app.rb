require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/') do
  @categories = Category.all
  erb(:index)
end

#---------------post new category
post('/') do
  description = params.fetch('description')
  Category.create({:description => description})
  @categories = Category.all
  erb(:index)
end

#----------------category page with recipes
get('/category/:id/recipes') do
  id = params.fetch('id').to_i
  @category = Category.find(id)
  @recipes = @category.recipes()
  erb(:recipes)
end

#---------------------delete a category
delete('/category/:id') do
  id = params.fetch('id').to_i
  category = Category.find(id)
  category.destroy()
  @categories = Category.all
  erb(:index)
end

#--------------------one recipe page
get('/category/:category_id/recipe/:id') do
  @id = params.fetch('id').to_i
  @recipe = Recipe.find(@id)
  erb(:recipe)
end

#---------------------create a new recipe
get('/recipes/new') do
  @categories = Category.all
  erb(:recipe_form)
end

post('/recipes') do
  name = params.fetch('name')
  instruction = params.fetch('instruction')
  category_ids = params.fetch('category_ids')
  new_recipe = Recipe.create({:name => name, :instruction => instruction})
  length = category_ids.length()
  length.times() do |time|
    id = category_ids[time].to_i
    category = Category.find(id)
    category.recipes.push(new_recipe)
  end
  @categories = Category.all
  erb(:index)
end

#--------------------update a recipe
patch('/recipes/:id/edit') do
  @category = Category.find(category_id)
  @category.recipes.push(new_recipe)
  @recipes = @category.recipes()
  erb(:recipes)
end
