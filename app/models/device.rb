class Device < ActiveRecord::Base
  has_many :dnotes
  has_many :tickets
  belongs_to :customers

  self.table_name = "Devices"

  def self.search(filter_item, filter_item2)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item

      filter_item2.nil? ? filter_item2 = "" : filter_item2

      case filter_item2
      when "0"
        cus = Customer.find_by_id(filter_item)
        if !cus.nil? 
          devices = Device.where("owner LIKE ?", "%#{cus.username}%")
        end
      when "1"
        devices = Device.where("owner LIKE ?", "%#{tmp}%")
      when "2"
        devices = Device.where("name like ?", "%#{tmp}%")
      else
        devices = Device.where("owner LIKE ? OR name like ? OR device_type like ? OR location like ? OR public_ip like ? OR private_ip LIKE ? OR device_note LIKE ? OR osname LIKE ? OR osram LIKE ? OR osprocessor LIKE ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%")
      end
        
    else
      devices = Device.all
    end

    return devices
  end

  def self.change_owner(old, xin)
    devices = Device.where(:owner=>old)

    if !devices.blank?
      devices.each do |d|
        d.update(:owner=>xin)
      end
      return true
    else
      return false
    end

  end

  def self.saction(params)
    if !params.blank? && !params[:dnote_id].nil?
      tmp = params
      # respond a request_order
      td = Dnote.find_by_id(tmp["dnote_id"])
      td.is_checked = tmp["request_order"]
      td.save

      tes = Dnote.where(:is_checked=>"0").where(:device_id=>tmp["device_id"]).count
      # mark none-request devices
      if tes == 0
        te = Device.find_by_id(tmp["device_id"])
        te.detail = "false"
        te.save
      end 
    end
  end

  def self.delete_device(device_id)
    if !device_id.nil?
      tt = Device.find_by_id(device_id)
      dnotes = Dnote.where(:device_id=>device_id)

      if !tt.nil?
        tt.delete

        if !dnotes.blank?
          dnotes.delete_all
        end

        return true
      else
        return false
      end
    end

    return false
  end

  def self.delete_log(params)
    did = params[:dnote_id]

    dn = Dnote.find_by_id(did)
    if !dn.nil?
      dn.delete
    end
  end


  def self.device_sortable(column, direction)
    case column
    when "Name"
      col = "name "
    when "Device Type"
      col = "device_type "
    when "Location"
      col = "location "
    when "Public IP"
      col = "public_ip "
    when "Private IP"
      col = "private_ip "
    when "Note"
      col = "device_note "
    when "Addons"
      col = "addons "
    when "OS Name"
      col = "osname "
    when "OS RAM"
      col = "osram "
    when "OS Processor"
      col = "osprocessor "
    else
      col = " "
    end

    return col + direction
  end

  def self.configure_sortable(column, direction)
    case column
    when "Name"
      col = "name "
    when "Device Type"
      col = "device_type "
    when "Location"
      col = "location "
    when "Public IP"
      col = "public_ip "
    when "Private IP"
      col = "private_ip "
    when "Note"
      col = "device_note "
    when "Addons"
      col = "addons "
    when "Status"
      col = "general_status "
    when "Reloaded"
      col = "general_reloaded "
    when "OS Name"
      col = "osname "
    when "OS RAM"
      col = "osram "
    when "OS Processor"
      col = "osprocessor "
    when "Created at"
      col = "created_at "
    else
      col = " "
    end

    return col + direction
  end

  def self.to_thdindex2(sort_item)
    case sort_item
    when "Name"
      col = 0
    when "Device Type"
      col = 1
    when "Location"
      col = 2
    when "Public IP"
      col = 3
    when "Private IP"
      col = 4
    when "Note"
      col = 5
    when "Addons"
      col = 6
    when "Status"
      col = 7
    when "Reloaded"
      col = 8
    when "OS Name"
      col = 9
    when "OS RAM"
      col = 10
    when "OS Processor"
      col = 11
    when "Created at"
      col = 12
    else
      col = 13
    end

    return col
  end

  def self.to_thdindex(sort_item)
    case sort_item
    when "Name"
      col = 0
    when "Device Type"
      col = 1
    when "Location"
      col = 2
    when "Public IP"
      col = 3
    when "Private IP"
      col = 4
    when "Note"
      col = 5
    when "Addons"
      col = 6
    when "OS Name"
      col = 7
    when "OS RAM"
      col = 8
    when "OS Processor"
      col = 9
    else
      col = 10
    end

    return col
  end
end
