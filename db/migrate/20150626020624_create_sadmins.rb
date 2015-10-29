class CreateSadmins < ActiveRecord::Migration
  def change
    create_table :Sadmins do |t|
      t.string :username
      t.string :password
      t.string :email
      
      t.boolean :is_rticket
      t.boolean :is_cticket
      t.boolean :is_dticket
      t.boolean :is_cdevice
      t.boolean :is_rdevice
      t.boolean :is_mdevice

      t.boolean :is_caccount
      t.boolean :is_maccount
      t.boolean :is_daccount

      t.boolean :is_ccustomer
      t.boolean :is_rcustomer
      t.boolean :is_mcustomer

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
