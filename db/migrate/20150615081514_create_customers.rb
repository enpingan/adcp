class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :Customers do |t|
      t.string :username
      t.string :password
      t.boolean :is_rticket
      t.boolean :is_wticket
      t.boolean :is_dticket
      t.boolean :is_sticket
      t.boolean :is_cdevice
      t.boolean :is_rdevice
      t.boolean :is_mdevice

      t.timestamps null: false
    end
  end
end
