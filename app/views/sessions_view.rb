class SessionsView
  def ask_for_username
    puts "Username?"
    gets.chomp
  end

  def ask_for_password
    puts "Password?"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong Credentials... try again"
  end

  def welcome(employee)
    puts "Welcome #{employee.username}"
  end

end