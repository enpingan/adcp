class Pcustomer < ActiveRecord::Base
  self.table_name = "Pcustomers"

  def self.search(filter_item)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      pcustomers=Pcustomer.where("id LIKE ? OR username like ? OR password like ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}")
    else
      pcustomers = Pcustomer.all
    end

    return pcustomers
  end

  def self.delete_pcustomer(pcustomer_id)
    if !pcustomer_id.nil?
      tt = Pcustomer.find_by_id(pcustomer_id)

      if !tt.nil?
        tt.delete

        return true
      else
        return false
      end
    end

    return false
  end

  def self.pcustomer_sortable(column, direction)
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
