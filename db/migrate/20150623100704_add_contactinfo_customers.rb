class AddContactinfoCustomers < ActiveRecord::Migration
  def change
    add_column :Customers, :first_name, :string
    add_column :Customers, :last_name, :string
    add_column :Customers, :city, :string
    add_column :Customers, :state, :string
    add_column :Customers, :country, :string
    add_column :Customers, :pemail, :string
    add_column :Customers, :number, :string
    add_column :Customers, :account_type, :string
  end
end
