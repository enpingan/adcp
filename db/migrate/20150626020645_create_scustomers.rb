class CreateScustomers < ActiveRecord::Migration
  def change
    create_table :Scustomers do |t|
      t.string :username
      t.string :password
      t.boolean :is_rticket
      t.boolean :is_wticket
      t.boolean :is_dticket
      t.boolean :is_sticket
      t.boolean :is_cdevice
      t.boolean :is_rdevice
      t.boolean :is_mdevice

      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :country
      t.string :pemail
      t.string :number
      t.string :account_type

      t.timestamps null: false
    end
  end
end
