class MealsView

  def display(meals)
    puts "------------------"
    puts "Avaliable Meals"
    puts "------------------"
    meals.each do |meal|
      puts "#{meal.id} - #{meal.name}: R$#{meal.price}"
    end
    puts "------------------"
  end

  def ask_name
    puts "Meal name?"
    gets.chomp
  end

  def ask_price
    puts "Meal price?"
    gets.chomp.to_i
  end
end