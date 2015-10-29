class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :Accounts do |t|
      t.string :email_addr
      t.string :ssl_name
      t.string :hs_pwd
      t.string :pwd

      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :country
      t.string :pemail
      t.string :number
      t.string :account_type
      
      t.boolean :is_cticket
      t.boolean :is_rticket
      t.boolean :is_dticket
      t.boolean :is_cdevice
      t.boolean :is_rdevice
      t.boolean :is_mdevice

      t.timestamps null: false
    end
  end
end
