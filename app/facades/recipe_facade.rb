class RecipeFacade
  def self.search_recipes(country)
    recipes = RecipeService.get_recipe_by_country(country)
    recipes[:hits].map {|hit| Recipe.new(hit[:recipe], country)}
  end
end