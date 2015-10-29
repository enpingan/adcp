class CreateDnotes < ActiveRecord::Migration
  def change
    create_table :Dnotes do |t|
      t.string :device_id
      t.string :device_name
      t.string :device_status
      t.string :request_order
      t.string :is_checked

      t.timestamps null: false
    end
  end
end
