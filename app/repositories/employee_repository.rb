require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv if File.exist?(@csv_file)
  end

  def all
    @employees
  end

  def find(id)
    @employees.select {|employee| employee.id == id }.first
  end

  def find_by_username(username)
    @employees.select {|employee| employee.username == username}.first
  end

  def all_delivery_guys
    @employees.select {|employee| employee.delivery_guy? }
  end

  def load_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end






