class Scustomer < ActiveRecord::Base
  self.table_name = "Scustomers"

  def self.search(filter_item)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      scustomers = Scustomer.where("id LIKE ? OR username like ? OR password like ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}")
    else
      scustomers = Scustomer.all
    end

    return scustomers
  end

  def self.delete_scustomer(scustomer_id)
    if !scustomer_id.nil?
      tt = Scustomer.find_by_id(scustomer_id)

      if !tt.nil?
        tt.delete

        return true
      else
        return false
      end
    end

    return false
  end

  def self.scustomer_sortable(column, direction)
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
