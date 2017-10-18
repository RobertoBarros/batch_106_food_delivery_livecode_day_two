require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def list
    #get all meals
    meals = @meal_repository.all
    #call view with all meals
    @view.display(meals)
  end

  def add
    # Ask for name
    name = @view.ask_name
    # Ask price
    price = @view.ask_price
    # Instaciate new meal
    new_meal = Meal.new(name: name, price: price)
    # persist
    @meal_repository.add(new_meal)
  end
end