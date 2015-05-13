require('spec_helper')

describe(Recipe) do
  it('ensures the length of name to be no more than 50 characters') do
    recipe = Recipe.new({:name => "W".*(51)})
    expect(recipe.save()).to(eq(false))
  end
end
