class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# establish_connection "user_panel_#{Rails.env}"
  self.table_name = "Users"

  def self.search(filter_item)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      accounts = User.where("id LIKE ? OR ssl_name like ? OR hs_pwd like ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}")
    else
      accounts = User.all
    end

    return accounts
  end

  def self.delete_account(account_id)
    if !account_id.nil?
      tt = User.find_by_id(account_id)

      if !tt.nil?
        tt.delete

        return true
      else
        return false
      end
    end

    return false
  end

  def self.userinfo_sortable(column, direction)
    case column
    when "ID"
      col = "id "
    when "Username"
      col = "ssl_name "
    else
      col = " "
    end

    return col + direction
  end

  def self.to_thdindex(sort_item)
    case sort_item
    when "ID"
      col = 0
    when "Username"
      col = 1
    else
      col = 2
    end

    return col
  end
end
