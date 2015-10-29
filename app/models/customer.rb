class Customer < ActiveRecord::Base
  has_many :devices
  
  self.table_name = "Customers"

  def self.search(filter_item)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      customers = Customer.where("id LIKE ? OR username like ? OR password like ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}")
    else
      customers = Customer.all
    end

    return customers
  end

  def self.delete_customer(customer_id)
    if !customer_id.nil?
      tt = Customer.find_by_id(customer_id)
      tu = User.find_by_id(customer_id)

      devices = Device.where(:owner=>tt.username)

      if !tt.nil?
        sc = Scustomer.new(:id=>tt.id.to_s, :username=>tt.username, :password=>tt.password, :is_rticket=>tt.is_rticket,:is_wticket=>tt.is_rticket,:is_dticket=>tt.is_rticket,:is_sticket=>tt.is_rticket,:is_cdevice=>tt.is_cdevice,:is_rdevice=>tt.is_rdevice,:is_mdevice=>tt.is_mdevice,:first_name=>tt.first_name, :last_name=>tt.last_name, :city=>tt.city, :state=>tt.state, :country=>tt.country, :number=>tt.number, :pemail=>tt.pemail)
        sc.save
        
        tt.delete

        if !tu.nil?
          tu.delete
        end

        if !devices.blank?
          devices.delete_all
        end

        return true
      else
        return false
      end
    end

    return false
  end

  def self.resume_device(id)
    tmp = Device.find_by_id(id)

    if !tmp.nil?
      if tmp.general_status == "Active"
        tmp.general_status = "Deactive"
      else
        tmp.general_status = "Active"
      end

      tmp.save
    end 
  end

  def self.customer_sortable(column, direction)
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
