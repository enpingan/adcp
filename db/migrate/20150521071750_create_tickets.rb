class CreateTickets < ActiveRecord::Migration
  def change
    create_table :Tickets do |t|
      t.integer :device_id
      t.string :ticket_group
      t.string :subject
      t.string :owner
      t.string :last_replied
      t.string :device
      t.string :updated
      t.integer :user_id
      t.boolean :is_read
      t.string :detail

      t.timestamps null: false
    end
  end
end
