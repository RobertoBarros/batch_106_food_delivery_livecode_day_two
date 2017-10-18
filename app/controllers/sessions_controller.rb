require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def sign_in
    # ask for username
    username = @view.ask_for_username
    # ask for password
    password = @view.ask_for_password
    # Find employee by username
    employee = @employee_repository.find_by_username(username)
    # Compare passwords
    if employee && employee.password == password
      # if equal return the employee
      @view.welcome(employee)
      return employee
    else
      @view.wrong_credentials
      # else sign_in again
      sign_in
    end
  end

end