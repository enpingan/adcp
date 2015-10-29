class Sadmin < ActiveRecord::Base
  self.table_name = "Sadmins"

  def self.search(filter_item)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      sadmins = Sadmin.where("id LIKE ? OR username like ? OR password like ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}")
    else
      sadmins = Sadmin.all
    end

    return sadmins
  end

  def self.delete_sadmin(sadmin_id)
    if !sadmin_id.nil?
      tt = Sadmin.find_by_id(sadmin_id)

      if !tt.nil?
        tt.delete

        return true
      else
        return false
      end
    end

    return false
  end

  def self.sadmin_sortable(column, direction)
    case column
    when "ID"
      col = "id "
    when "Username"
      col = "username "
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
