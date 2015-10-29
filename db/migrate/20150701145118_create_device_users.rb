class CreateDeviceUsers < ActiveRecord::Migration
  def change
    create_table :Device_Users do |t|
      t.string :username
      t.string :password
      t.string :device_name

      t.timestamps null: false
    end
  end
end
