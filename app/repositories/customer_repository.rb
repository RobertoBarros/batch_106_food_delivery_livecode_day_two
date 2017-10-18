require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv if File.exists?(@csv_file)
  end

  def add(customer)
    customer.id = @next_id
    @customers << customer
    write_csv
    @next_id += 1
  end

  def all
    @customers
  end

  def find(id)
    @customers.select { |customer| customer.id == id}.first
  end

  private

  def write_csv
    CSV.open(@csv_file, 'w') do |csv|
      csv << [:id, :name, :address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      new_customer = Customer.new(row)
      @customers << new_customer
    end
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end
end

