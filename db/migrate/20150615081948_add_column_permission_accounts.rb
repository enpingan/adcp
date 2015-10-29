class AddColumnPermissionAccounts < ActiveRecord::Migration
  def change
    add_column :Accounts, :is_caccount, :boolean
    add_column :Accounts, :is_maccount, :boolean
    add_column :Accounts, :is_daccount, :boolean

    add_column :Accounts, :is_ccustomer, :boolean
    add_column :Accounts, :is_rcustomer, :boolean
    add_column :Accounts, :is_mcustomer, :boolean

    add_column :Verifieds, :is_caccount, :boolean
    add_column :Verifieds, :is_maccount, :boolean
    add_column :Verifieds, :is_daccount, :boolean

    add_column :Verifieds, :is_ccustomer, :boolean
    add_column :Verifieds, :is_dcustomer, :boolean
    add_column :Verifieds, :is_mcustomer, :boolean
  end
end
