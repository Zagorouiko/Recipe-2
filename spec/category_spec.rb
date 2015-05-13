require('spec_helper')

describe(Category) do
  it('ensures the length of description to be no more than 50 characters') do
    category = Category.new({:description => "W".*(51)})
    expect(category.save()).to(eq(false))
  end
end
