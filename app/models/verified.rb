class Verified < ActiveRecord::Base
  self.table_name = "Verifieds"

  def self.search(filter_item)
    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      verifieds = Verified.where("id LIKE ? OR username like ? OR password like ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}")
    else
      verifieds = Verified.all
    end

    return verifieds
  end

  def self.delete_verified(verified_id)
    if !verified_id.nil?
      tt = Verified.find_by_id(verified_id)
      tu = User.find_by_id(verified_id)

      if !tt.nil?
        tmp = Sadmin.new(:id=>tt.id.to_s,:username=>tt.username,:password=>tt.password,:email=>tt.email,:is_rticket=>tt.is_rticket,:is_cticket=>tt.is_cticket,:is_dticket=>tt.is_dticket,:is_cdevice=>tt.is_cdevice,:is_rdevice=>tt.is_rdevice,:is_mdevice=>tt.is_mdevice,:is_caccount=>tt.is_caccount,:is_maccount=>tt.is_maccount,:is_daccount=>tt.is_daccount,:first_name=>tt.first_name,:last_name=>tt.last_name,:city=>tt.city,:state=>tt.state,:country=>tt.country,:pemail=>tt.pemail,:number=>tt.number,:account_type=>tt.account_type,:is_ccustomer=>tt.is_ccustomer,:is_rcustomer=>tt.is_dcustomer,:is_mcustomer=>tt.is_mcustomer)
        tmp.save

        tt.delete

        if !tu.nil?
          tu.delete
        end

        return true
      else
        return false
      end
    end

    return false
  end

  def self.verified_sortable(column, direction)
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
