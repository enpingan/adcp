class AddColumnPermssionAdmin < ActiveRecord::Migration
  def change
    add_column :Users, :is_caccount, :boolean
    add_column :Users, :is_maccount, :boolean
    add_column :Users, :is_daccount, :boolean

    add_column :Users, :is_ccustomer, :boolean
    add_column :Users, :is_mcustomer, :boolean
    add_column :Users, :is_dcustomer, :boolean
  end
end
