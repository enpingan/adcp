class CreateComments < ActiveRecord::Migration
  def change
    create_table :Comments do |t|
      t.string :comment
      t.string :ticket_id
      t.string :ticket_owner

      t.timestamps null: false
    end
  end
end
