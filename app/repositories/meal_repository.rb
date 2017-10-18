require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1
    load_csv if File.exists?(@csv_file)
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    write_csv
    @next_id += 1
  end

  def all
    @meals
  end

  def find(id)
    @meals.select { |meal| meal.id == id}.first
  end

  private

  def write_csv
    CSV.open(@csv_file, 'w') do |csv|
      csv << [:id, :name, :price]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      new_meal = Meal.new(row)
      @meals << new_meal
    end
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end
end


# repository = MealRepository.new('../../data/meals.csv')

# pizza = Meal.new(name: 'pizza', price: 20)
# repository.add(pizza)

# repository.all.each {|meal| puts "#{meal.id} - #{meal.name}, #{meal.price}"}
