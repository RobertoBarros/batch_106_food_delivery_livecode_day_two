require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @view = OrdersView.new
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.display(orders)
  end

  def add
    # Ask for meal
    MealsController.new(@meal_repository).list
    meal_id = @view.ask_meal_id
    meal = @meal_repository.find(meal_id)
    # Ask for customer
    CustomersController.new(@customer_repository).list
    customer_id = @view.ask_customer_id
    customer = @customer_repository.find(customer_id)

    # Ask for delivery guy
    delivery_guys = @employee_repository.all_delivery_guys
    @view.display_delivery_guys(delivery_guys)
    employee_id = @view.ask_employee_id
    employee = @employee_repository.find(employee_id)

    # Create a new order
    new_order = Order.new(meal: meal, employee: employee, customer: customer)

    # add to repository
    @order_repository.add(new_order)

  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }

    @view.display(orders)

  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    order_id = @view.ask_order_id
    order = @order_repository.find(order_id)
    order.deliver!
    @order_repository.save


  end


end