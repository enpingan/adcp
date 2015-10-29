class CreateDevices < ActiveRecord::Migration
  def change
    create_table :Devices do |t|
      t.string :owner
      t.string :name
      t.string :device_type
      t.string :location
      t.string :public_ip
      t.string :private_ip
      t.string :device_note
      t.string :addons
      t.string :general_status
      t.string :general_reloaded
      t.string :osname
      t.string :osram
      t.string :osprocessor
      t.string :detail

      t.timestamps null: false
    end
  end
end
