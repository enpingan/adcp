class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :Visitors do |t|
      t.string :ip_address
      t.string :visit_count
      t.string :username

      t.timestamps null: false
    end
  end
end
