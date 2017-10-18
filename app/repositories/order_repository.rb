require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @csv_file = csv_file
    @employee_repository = employee_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository

    @orders = []

    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @orders
  end

  def find(id)
    @orders.select {|order| order.id == id }.first
  end

  def add(order)
    order.id = @next_id
    @orders << order
    write_csv
    @next_id += 1
  end

  def undelivered_orders
    @orders.select {|order| !order.delivered? }
  end

  def save
    write_csv
  end

  private

  def write_csv
    CSV.open(@csv_file, 'w') do |csv|
      csv << [:id, :delivered, :meal_id, :employee_id, :customer_id]

      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end

  def load_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'

      new_order = Order.new(row)

      meal = @meal_repository.find(row[:meal_id].to_i)
      employee = @employee_repository.find(row[:employee_id].to_i)
      customer = @customer_repository.find(row[:customer_id].to_i)

      new_order.meal = meal
      new_order.employee = employee
      new_order.customer = customer

      @orders << new_order

    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end


end
