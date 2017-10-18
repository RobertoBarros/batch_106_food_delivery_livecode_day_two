class OrdersView
  def ask_meal_id
    puts "Meal id?"
    gets.chomp.to_i
  end

  def ask_customer_id
    puts "Customer id?"
    gets.chomp.to_i
  end

  def ask_employee_id
    puts "Employee id?"
    gets.chomp.to_i
  end

  def ask_order_id
    puts "Order id?"
    gets.chomp.to_i
  end

  def display_delivery_guys(delivery_guys)
    delivery_guys.each do |delivery_guy|
      puts "#{delivery_guy.id} - #{delivery_guy.username}"
    end
  end

  def display(orders)
    orders.each do |order|
      puts "#{order.id}. Customer: #{order.customer.name} Meal: #{order.meal.name} "
    end
  end


end