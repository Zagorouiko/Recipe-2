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
  redirect('/')
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
  redirect('/')
end

#--------------------one recipe page
get('/category/:category_id/recipe/:id') do
  id = params.fetch('id').to_i
  category_id = params.fetch('category_id').to_i
  @category = Category.find(category_id)
  @recipe = Recipe.find(id)
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
  rating = params.fetch('rating_dropdown').to_i
  category_ids = params.fetch('category_ids')
  new_recipe = Recipe.create({:name => name, :instruction => instruction, :rating => rating})
  length = category_ids.length()
  length.times() do |time|
    id = category_ids[time].to_i
    category = Category.find(id)
    category.recipes.push(new_recipe)
  end
  redirect('/')
end

#--------------------update a recipe
patch('/category/:category_id/recipe/:id') do
  name = params.fetch('name')
  instructions = params.fetch('instructions')
  rating = params.fetch('rating_dropdown').to_i
  id = params.fetch('id').to_i
  @recipe = Recipe.find(id)
  @recipe.update({:name => name, :instruction => instructions, :rating => rating})
  category_id = params.fetch('category_id')
  @category = Category.find(category_id)
  erb(:recipe)
end

#---------------------delete a recipe
delete('/category/:category_id/recipe/:id') do
  id = params.fetch('id').to_i
  recipe = Recipe.find(id)
  recipe.destroy()
  category_id = params.fetch('category_id').to_i
  @category = Category.find(category_id)
  @recipes = @category.recipes()
  erb(:recipes)
end

#-----------------------see all recipes
get('/recipes') do
  erb(:all_recipes)
end
