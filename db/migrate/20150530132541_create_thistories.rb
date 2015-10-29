class CreateThistories < ActiveRecord::Migration
  def change
    create_table :Thistories do |t|
      t.string :comment
      t.string :ticket_id
      t.string :ticket_owner

      t.timestamps null: false
    end
  end
end
