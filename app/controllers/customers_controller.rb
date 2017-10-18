require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def list
    #get all customers
    customers = @customer_repository.all
    #call view with all customers
    @view.display(customers)
  end

  def add
    # Ask for name
    name = @view.ask_name
    # Ask price
    address = @view.ask_address
    # Instaciate new customer
    new_customer = Customer.new(name: name, address: address)
    # persist
    @customer_repository.add(new_customer)
  end
end