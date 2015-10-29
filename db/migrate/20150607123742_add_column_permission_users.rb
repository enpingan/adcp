class AddColumnPermissionUsers < ActiveRecord::Migration
  def change
    add_column :Users, :is_rticket, :boolean
    add_column :Users, :is_cticket, :boolean
    add_column :Users, :is_dticket, :boolean

    add_column :Users, :is_cdevice, :boolean
    add_column :Users, :is_rdevice, :boolean
    add_column :Users, :is_mdevice, :boolean

    add_column :Users, :first_name, :string
    add_column :Users, :last_name, :string
    add_column :Users, :city, :string
    add_column :Users, :state, :string
    add_column :Users, :country, :string
    add_column :Users, :pemail, :string
    add_column :Users, :number, :string
    add_column :Users, :account_type, :string
  end
end
