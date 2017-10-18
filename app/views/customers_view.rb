class CustomersView

  def display(customers)
    puts "------------------"
    puts "Avaliable Customers"
    puts "------------------"
    customers.each do |customer|
      puts "#{customer.id} - #{customer.name}: #{customer.address}"
    end
    puts "------------------"
  end

  def ask_name
    puts "Customer name?"
    gets.chomp
  end

  def ask_address
    puts "Customer address?"
    gets.chomp
  end
end