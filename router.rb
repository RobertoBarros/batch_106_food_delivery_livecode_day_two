class Router

  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def run

    employee = @sessions_controller.sign_in

    loop do
      if employee.manager?
        option = print_manager_options
        case option
        when 1 then @meals_controller.list
        when 2 then @meals_controller.add
        when 3 then @customers_controller.list
        when 4 then @customers_controller.add
        when 5 then @orders_controller.list_undelivered_orders
        when 6 then @orders_controller.add
        end
      end

      if employee.delivery_guy?
        option = print_delivery_guy_options
        case option
        when 1 then @orders_controller.list_my_orders(employee)
        when 2 then @orders_controller.mark_as_delivered(employee)
        end
      end
    end

  end

  def print_manager_options
    puts "Choose an option"
    puts "1. List Meals"
    puts "2. Add Meal"
    puts "3. List Customers"
    puts "4. Add Customers"
    puts "5. List undeliverd orders"
    puts "6. Create new order"
    return gets.chomp.to_i
  end

  def print_delivery_guy_options
    puts "Choose an option"
    puts "1. List my undeliverd orders"
    puts "2. Mark order as delivered"
    return gets.chomp.to_i
  end


end
