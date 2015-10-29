module DevicesHelper
  def get_devicename(email_addr)
    return email_addr.split('@').first + '_server'
  end

  def getflag_floc(location)
    case location

    when "Amsterdam1"
      return '<i class="netherlands flag" style="font-size:20x;"></i>'
    when "Amsterdam2"
      return '<i class="netherlands flag" style="font-size:20x;"></i>'
    when "Frankfurt2"
      return '<i class="germany flag" style="font-size:20x;"></i>'
    when "HongKong2"
      return '<i class="hong kong flag"  style="font-size:20x;"></i>'
    when "Paris1"
      return '<i class="france flag"  style="font-size:20x;"></i>'
    else
      return '<i class="united states flag"  style="font-size:20x;"></i>'
    end
  end

end
