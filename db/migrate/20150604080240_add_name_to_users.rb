class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :Users, :username, :string
    add_column :Users, :pwd, :string
  end
end
