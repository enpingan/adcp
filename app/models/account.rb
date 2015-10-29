class Account < ActiveRecord::Base
  # establish_connection "user_panel_#{Rails.env}"
  self.table_name = "Accounts"

  def self.search(filter_item)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      accounts = Account.where("id LIKE ? OR ssl_name like ? OR hs_pwd like ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}")
    else
      accounts = Account.all
    end

    return accounts
  end

  def self.delete_account(account_id)
    if !account_id.nil?
      tt = Account.find_by_id(account_id)

      if !tt.nil?
        tt.delete

        return true
      else
        return false
      end
    end

    return false
  end

  def self.account_sortable(column, direction)
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

  def self.account_sortable2(column, direction)
    case column
    when "User"
      col = "username "
    # when "Location"
    #   col = "location "
    when "Last Login"
      col = "last_sign_in_at "
    when "Last IP"
      col = "last_sign_in_ip "
    else
      col = " "
    end

    return col + direction
  end

  def self.to_thdindex2(sort_item)
    case sort_item
    when "User"
      col = 0
    # when "Location"
    #   col = 1
    when "Last Login"
      col = 2
    when "Last IP"
      col = 3
    else
      col = 4
    end

    return col
  end



end
