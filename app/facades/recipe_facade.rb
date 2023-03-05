class RecipeFacade
  def self.search_recipes(country)
    recipes = RecipeService.get_recipe_by_country(country)
    recipes[:hits].map {|recipe| Recipe.new(recipe, country)}
  end
end