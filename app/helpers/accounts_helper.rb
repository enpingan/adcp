module AccountsHelper

  def is_adminuser(email)
    if email == "CyberAdvance"
      return true
    else
      return false
    end
  end

  def processblank(value)
    if value == "" || value.nil?
      return "---"
    else
      return value
    end
  end

  def get_devices(email)
    @own_devices = Device.where(:owner=>email)
    return @own_devices
  end

  def get_checkicon(value)
    if value 
      html = '<i class="fa fa-fw fa-check-square" style="color:palegoldenrod;font-size:18px;"></i>'
    else
      html = '<i class="fa fa-fw fa-ban" style="color:#f39c12;font-size:18px;"></i>'
    end

    return html
  end

  def get_colorspan(b_val, value)

    if b_val == "updated"
      html = '<span style="color:#f39c12">' + value.to_s + '</span>'
    else
      html = value
    end

    return html
  end

  def get_colorspan_ticket(b_val, value)

    if b_val
      html = '<span style="color:#f39c12">' + value.to_s + '</span>'
    else
      html = value
    end

    return html
  end

  def hp_device(username)
    tmp = User.find_by_username(username)

    if !tmp.nil?
      if tmp.is_cdevice || tmp.is_rdevice || tmp.is_mdevice
        return true
      else
        return false
      end
    else
      return false
    end
    
  end

  def hp_ticket(username)
    tmp = User.find_by_username(username)
    
    if !tmp.nil?
      if tmp.is_rticket || tmp.is_cticket || tmp.is_dticket
        return true
      else
        return false
      end
    else
      return false
    end    
  end

  def hp_customer(username)
    tmp = User.find_by_username(username)
    
    if !tmp.nil?
      if tmp.is_ccustomer || tmp.is_mcustomer || tmp.is_dcustomer
        return true
      else
        return false
      end
    else
      return false
    end    
  end

  def hp_account(username)
    tmp = User.find_by_username(username)
    
    if !tmp.nil?
      if tmp.is_caccount || tmp.is_maccount || tmp.is_daccount
        return true
      else
        return false
      end
    else
      return false
    end 
  end


  def get_devicecount(email)
    tmp = email
    @devices = Device.where(:owner=>tmp)
    return @devices.count
  end

  def get_ticketcount(email)
    tmp = email
    @tickets = Ticket.where(:owner=>tmp)
    return @tickets.count
  end

  def get_userid(username)
    tu = User.find_by_username(username)
    tid = tu.id.to_i
    return tid
  end

  def comments_by_ticketid(id)
    tmp = Comment.where(:ticket_id=>id)
    retval = tmp.count
    return retval
  end

  def get_accounttype(name)
    tmp = User.find_by_username(name)
    retval = tmp.account_type
    return retval
  end

  def is_account(name)
    tmp = User.find_by_username(name)

    if tmp.nil?
      tmp = User.find_by_email(name)
    end

    if !tmp.nil?
      if !tmp.account_type.nil? || tmp.username == "CyberAdvance"
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def get_countryname(name)
    case name
    when "Andorra"
      html = '<i class="ad flag"></i>'
    when "Afghanistan"
      html = '<i class="af flag"></i>Afghanistan'
    when "Antigua"
      html = '<i class="ag flag"></i>Antigua'
    when "Anguilla"
      html = '<i class="ai flag"></i>Anguilla'
    when "Albania"
      html = '<i class="al flag"></i>Albania'
    when "Armenia"
      html = '<i class="am flag"></i>Armenia'
    when "Netherlands Antilles"
      html = '<i class="an flag"></i>Netherlands Antilles'
    when "Angola"
      html = '<i class="ao flag"></i>Angola'
    when "Argentina"
      html = '<i class="ar flag"></i>Argentina'
    when "American Samoa"
      html = '<i class="as flag"></i>American Samoa'
    when "Austria"
      html = '<i class="at flag"></i>Austria'
    when "Australia"
      html = '<i class="au flag"></i>Australia'
    when "Aruba"
      html = '<i class="aw flag"></i>Aruba'
    when "Aland Islands"
      html = '<i class="ax flag"></i>Aland Islands'
    when "Azerbaijan"
      html = '<i class="az flag"></i>Azerbaijan'
    when "Bosnia"
      html = '<i class="ba flag"></i>Bosnia'
    when "Barbados"
      html = '<i class="bb flag"></i>Barbados'
    when "Bangladesh"
      html = '<i class="bd flag"></i>Bangladesh'
    when "Belgium"
      html = '<i class="be flag"></i>Belgium'
    when "Burkina Faso"
      html = '<i class="bf flag"></i>Burkina Faso'
    when "Bulgaria"
      html = '<i class="bg flag"></i>Bulgaria'
    when "Bahrain"
      html = '<i class="bh flag"></i>Bahrain'
    when "Burundi"
      html = '<i class="bi flag"></i>Burundi'
    when "Benin"
      html = '<i class="bj flag"></i>Benin'
    when "Bermuda"
      html = '<i class="bm flag"></i>Bermuda'
    when "Brunei"
      html = '<i class="bn flag"></i>Brunei'
    when "Bolivia"
      html = '<i class="bo flag"></i>Bolivia'
    when "Brazil"
      html = '<i class="br flag"></i>Brazil'
    when "Bahamas"
      html = '<i class="bs flag"></i>Bahamas'
    when "Bhutan"
      html = '<i class="bt flag"></i>Bhutan'
    when "Bouvet Island"
      html = '<i class="bv flag"></i>Bouvet Island'
    when "Botswana"
      html = '<i class="bw flag"></i>Botswana'
    when "Belarus"
      html = '<i class="by flag"></i>Belarus'
    when "Belize"
      html = '<i class="bz flag"></i>Belize'
    when "Canada"
      html = '<i class="ca flag"></i>Canada'
    when "Cocos Islands"
      html = '<i class="cc flag"></i>Cocos Islands'
    when "Congo"
      html = '<i class="cd flag"></i>Congo'
    when "Central African Republic"
      html = '<i class="cf flag"></i>Central African Republic'
    when "Congo Brazzaville"
      html = '<i class="cg flag"></i>Congo Brazzaville'
    when "Switzerland"
      html = '<i class="ch flag"></i>Switzerland'
    when "Cote Divoire"
      html = '<i class="ci flag"></i>Cote Divoire'
    when "Cook Islands"
      html = '<i class="ck flag"></i>Cook Islands'
    when "Chile"
      html = '<i class="cl flag"></i>Chile'
    when "Cameroon"
      html = '<i class="cm flag"></i>Cameroon'
    when "China"
      html = '<i class="cn flag"></i>China'
    when "Colombia"
      html = '<i class="co flag"></i>Colombia'
    when "Costa Rica"
      html = '<i class="cr flag"></i>Costa Rica'
    when "Serbia"
      html = '<i class="cs flag"></i>Serbia'
    when "Cuba"
      html = '<i class="cu flag"></i>Cuba'
    when "Cape Verde"
      html = '<i class="cv flag"></i>Cape Verde'
    when "Christmas Island"
      html = '<i class="cx flag"></i>Christmas Island'
    when "Cyprus"
      html = '<i class="cy flag"></i>Cyprus'
    when "Czech Republic"
      html = '<i class="cz flag"></i>Czech Republic'
    when "Germany"
      html = '<i class="de flag"></i>Germany'
    when "Djibouti"
      html = '<i class="dj flag"></i>Djibouti'
    when "Denmark"
      html = '<i class="dk flag"></i>Denmark'
    when "Dominica"
      html = '<i class="dm flag"></i>Dominica'
    when "Dominican Republic"
      html = '<i class="do flag"></i>Dominican Republic'
    when "Algeria"
      html = '<i class="dz flag"></i>Algeria'
    when "Ecuador"
      html = '<i class="ec flag"></i>Ecuador'
    when "Estonia"
      html = '<i class="ee flag"></i>Estonia'
    when "Egypt"
      html = '<i class="eg flag"></i>Egypt'
    when "Western Sahara"
      html = '<i class="eh flag"></i>Western Sahara'
    when "Eritrea"
      html = '<i class="er flag"></i>Eritrea'
    when "Spain"
      html = '<i class="es flag"></i>Spain'
    when "Ethiopia"
      html = '<i class="et flag"></i>Ethiopia'
    when "European Union"
      html = '<i class="eu flag"></i>European Union'
    when "Finland"
      html = '<i class="fi flag"></i>Finland'
    when "Fiji"
      html = '<i class="fj flag"></i>Fiji'
    when "Falkland Islands"
      html = '<i class="fk flag"></i>Falkland Islands'
    when "Micronesia"
      html = '<i class="fm flag"></i>Micronesia'
    when "Faroe Islands"
      html = '<i class="fo flag"></i>Faroe Islands'
    when "France"
      html = '<i class="fr flag"></i>France'
    when "Gabon"
      html = '<i class="ga flag"></i>Gabon'
    when "England"
      html = '<i class="gb flag"></i>England'
    when "Grenada"
      html = '<i class="gd flag"></i>Grenada'
    when "Georgia"
      html = '<i class="ge flag"></i>Georgia'
    when "French Guiana"
      html = '<i class="gf flag"></i>French Guiana'
    when "Ghana"
      html = '<i class="gh flag"></i>Ghana'
    when "Gibraltar"
      html = '<i class="gi flag"></i>Gibraltar'
    when "Greenland"
      html = '<i class="gl flag"></i>Greenland'
    when "Gambia"
      html = '<i class="gm flag"></i>Gambia'
    when "Guinea"
      html = '<i class="gn flag"></i>Guinea'
    when "Guadeloupe"
      html = '<i class="gp flag"></i>Guadeloupe'
    when "Equatorial Guinea"
      html = '<i class="gq flag"></i>Equatorial Guinea'
    when "Greece"
      html = '<i class="gr flag"></i>Greece'
    when "Sandwich Islands"
      html = '<i class="gs flag"></i>Sandwich Islands'
    when "Guatemala"
      html = '<i class="gt flag"></i>Guatemala'
    when "Guam"
      html = '<i class="gu flag"></i>Guam'
    when "Guinea-Bissau"
      html = '<i class="gw flag"></i>Guinea-Bissau'
    when "Guyana"
      html = '<i class="gy flag"></i>Guyana'
    when "Hong Kong"
      html = '<i class="hk flag"></i>Hong Kong'
    when "Heard Island"
      html = '<i class="hm flag"></i>Heard Island'
    when "Honduras"
      html = '<i class="hn flag"></i>Honduras'
    when "Croatia"
      html = '<i class="hr flag"></i>Croatia'
    when "Haiti"
      html = '<i class="ht flag"></i>Haiti'
    when "Hungary"
      html = '<i class="hu flag"></i>Hungary'
    when "Indonesia"
      html = '<i class="id flag"></i>Indonesia'
    when "Ireland"
      html = '<i class="ie flag"></i>Ireland'
    when "Israel"
      html = '<i class="il flag"></i>Israel'
    when "India"
      html = '<i class="in flag"></i>India'
    when "Indian Ocean Territory"
      html = '<i class="io flag"></i>Indian Ocean Territory'
    when "Iraq"
      html = '<i class="iq flag"></i>Iraq'
    when "Iran"
      html = '<i class="ir flag"></i>Iran'
    when "Iceland"
      html = '<i class="is flag"></i>Iceland'
    when "Italy"
      html = '<i class="it flag"></i>Italy'
    when "Jamaica"
      html = '<i class="jm flag"></i>Jamaica'
    when "Jordan"
      html = '<i class="jo flag"></i>Jordan'
    when "Japan"
      html = '<i class="jp flag"></i>Japan'
    when "Kenya"
      html = '<i class="ke flag"></i>Kenya'
    when "Kyrgyzstan"
      html = '<i class="kg flag"></i>Kyrgyzstan'
    when "Cambodia"
      html = '<i class="kh flag"></i>Cambodia'
    when "Kiribati"
      html = '<i class="ki flag"></i>Kiribati'
    when "Comoros"
      html = '<i class="km flag"></i>Comoros'
    when "Saint Kitts and Nevis"
      html = '<i class="kn flag"></i>Saint Kitts and Nevis'
    when "North Korea"
      html = '<i class="kp flag"></i>North Korea'
    when "South Korea"
      html = '<i class="kr flag"></i>South Korea'
    when "Kuwait"
      html = '<i class="kw flag"></i>Kuwait'
    when "Cayman Islands"
      html = '<i class="ky flag"></i>Cayman Islands'
    when "Kazakhstan"
      html = '<i class="kz flag"></i>Kazakhstan'
    when "Laos"
      html = '<i class="la flag"></i>Laos'
    when "Lebanon"
      html = '<i class="lb flag"></i>Lebanon'
    when "Saint Lucia"
      html = '<i class="lc flag"></i>Saint Lucia'
    when "Liechtenstein"
      html = '<i class="li flag"></i>Liechtenstein'
    when "Sri Lanka"
      html = '<i class="lk flag"></i>Sri Lanka'
    when "Liberia"
      html = '<i class="lr flag"></i>Liberia'
    when "Lesotho"
      html = '<i class="ls flag"></i>Lesotho'
    when "Lithuania"
      html = '<i class="lt flag"></i>Lithuania'
    when "Luxembourg"
      html = '<i class="lu flag"></i>Luxembourg'
    when "Latvia"
      html = '<i class="lv flag"></i>Latvia'
    when "Libya"
      html = '<i class="ly flag"></i>Libya'
    when "Morocco"
      html = '<i class="ma flag"></i>Morocco'
    when "Monaco"
      html = '<i class="mc flag"></i>Monaco'
    when "Moldova"
      html = '<i class="md flag"></i>Moldova'
    when "Montenegro"
      html = '<i class="me flag"></i>Montenegro'
    when "Madagascar"
      html = '<i class="mg flag"></i>Madagascar'
    when "Marshall Islands"
      html = '<i class="mh flag"></i>Marshall Islands'
    when "MacEdonia"
      html = '<i class="mk flag"></i>MacEdonia'
    when "Mali"
      html = '<i class="ml flag"></i>Mali'
    when "Burma"
      html = '<i class="ar flag"></i>Burma'
    when "Mongolia"
      html = '<i class="mn flag"></i>Mongolia'
    when "MacAu"
      html = '<i class="mo flag"></i>MacAu'
    when "Northern Mariana Islands"
      html = '<i class="mp flag"></i>Northern Mariana Islands'
    when "Martinique"
      html = '<i class="mq flag"></i>Martinique'
    when "Mauritania"
      html = '<i class="mr flag"></i>Mauritania'
    when "Montserrat"
      html = '<i class="ms flag"></i>Montserrat'
    when "Malta"
      html = '<i class="mt flag"></i>Malta'
    when "Mauritius"
      html = '<i class="mu flag"></i>Mauritius'
    when "Maldives"
      html = '<i class="mv flag"></i>Maldives'
    when "Malawi"
      html = '<i class="mw flag"></i>Malawi'
    when "Mexico"
      html = '<i class="mx flag"></i>Mexico'
    when "Malaysia"
      html = '<i class="my flag"></i>Malaysia'
    when "Mozambique"
      html = '<i class="mz flag"></i>Mozambique'
    when "Namibia"
      html = '<i class="na flag"></i>Namibia'
    when "New Caledonia"
      html = '<i class="nc flag"></i>New Caledonia'
    when "Niger"
      html = '<i class="ne flag"></i>Niger'
    when "Norfolk Island"
      html = '<i class="nf flag"></i>Norfolk Island'
    when "Nigeria"
      html = '<i class="ng flag"></i>Nigeria'
    when "Nicaragua"
      html = '<i class="ni flag"></i>Nicaragua'
    when "Netherlands"
      html = '<i class="nl flag"></i>Netherlands'
    when "Norway"
      html = '<i class="no flag"></i>Norway'
    when "Nepal"
      html = '<i class="np flag"></i>Nepal'
    when "Nauru"
      html = '<i class="nr flag"></i>Nauru'
    when "Niue"
      html = '<i class="nu flag"></i>Niue'
    when "New Zealand"
      html = '<i class="nz flag"></i>New Zealand'
    when "Oman"
      html = '<i class="om flag"></i>Oman'
    when "Panama"
      html = '<i class="pa flag"></i>Panama'
    when "Peru"
      html = '<i class="pe flag"></i>Peru'
    when "French Polynesia"
      html = '<i class="pf flag"></i>French Polynesia'
    when "New Guinea"
      html = '<i class="pg flag"></i>New Guinea'
    when "Philippines"
      html = '<i class="ph flag"></i>Philippines'
    when "Pakistan"
      html = '<i class="pk flag"></i>Pakistan'
    when "Poland"
      html = '<i class="pl flag"></i>Poland'
    when "Saint Pierre"
      html = '<i class="pm flag"></i>Saint Pierre'
    when "Pitcairn Islands"
      html = '<i class="pn flag"></i>Pitcairn Islands'
    when "Puerto Rico"
      html = '<i class="pr flag"></i>Puerto Rico'
    when "Palestine"
      html = '<i class="ps flag"></i>Palestine'
    when "Portugal"
      html = '<i class="pt flag"></i>Portugal'
    when "Palau"
      html = '<i class="pw flag"></i>Palau'
    when "Paraguay"
      html = '<i class="py flag"></i>Paraguay'
    when "Qatar"
      html = '<i class="qa flag"></i>Qatar'
    when "Reunion"
      html = '<i class="re flag"></i>Reunion'
    when "Romania"
      html = '<i class="ro flag"></i>Romania'
    when "Serbia"
      html = '<i class="rs flag"></i>Serbia'
    when "Russia"
      html = '<i class="ru flag"></i>Russia'
    when "Rwanda"
      html = '<i class="rw flag"></i>Rwanda'
    when "Saudi Arabia"
      html = '<i class="sa flag"></i>Saudi Arabia'
    when "Solomon Islands"
      html = '<i class="sb flag"></i>Solomon Islands'
    when "Seychelles"
      html = '<i class="sc flag"></i>Seychelles'
    when "Sudan"
      html = '<i class="sd flag"></i>Sudan'
    when "Sweden"
      html = '<i class="se flag"></i>Sweden'
    when "Singapore"
      html = '<i class="sg flag"></i>Singapore'
    when "Saint Helena"
      html = '<i class="sh flag"></i>Saint Helena'
    when "Slovenia"
      html = '<i class="si flag"></i>Slovenia'
    when "Svalbard, I Flag Jan Mayen"
      html = '<i class="sj flag"></i>Svalbard, I Flag Jan Mayen'
    when "Slovakia"
      html = '<i class="sk flag"></i>Slovakia'
    when "Sierra Leone"
      html = '<i class="sl flag"></i>Sierra Leone'
    when "San Marino"
      html = '<i class="sm flag"></i>San Marino'
    when "Senegal"
      html = '<i class="sn flag"></i>Senegal'
    when "Somalia"
      html = '<i class="so flag"></i>Somalia'
    when "Suriname"
      html = '<i class="sr flag"></i>Suriname'
    when "Sao Tome"
      html = '<i class="st flag"></i>Sao Tome'
    when "El Salvador"
      html = '<i class="sv flag"></i>El Salvador'
    when "Syria"
      html = '<i class="sy flag"></i>Syria'
    when "Swaziland"
      html = '<i class="sz flag"></i>Swaziland'
    when "Caicos Islands"
      html = '<i class="tc flag"></i>Caicos Islands'
    when "Chad"
      html = '<i class="td flag"></i>Chad'
    when "French Territories"
      html = '<i class="tf flag"></i>French Territories'
    when "Togo"
      html = '<i class="tg flag"></i>Togo'
    when "Thailand"
      html = '<i class="th flag"></i>Thailand'
    when "Tajikistan"
      html = '<i class="tj flag"></i>Tajikistan'
    when "Tokelau"
      html = '<i class="tk flag"></i>Tokelau'
    when "Timorleste"
      html = '<i class="tl flag"></i>Timorleste'
    when "Turkmenistan"
      html = '<i class="tm flag"></i>Turkmenistan'
    when "Tunisia"
      html = '<i class="tn flag"></i>Tunisia'
    when "Tonga"
      html = '<i class="to flag"></i>Tonga'
    when "Turkey"
      html = '<i class="tr flag"></i>Turkey'
    when "Trinidad"
      html = '<i class="tt flag"></i>Trinidad'
    when "Tuvalu"
      html = '<i class="tv flag"></i>Tuvalu'
    when "Taiwan"
      html = '<i class="tw flag"></i>Taiwan'
    when "Tanzania"
      html = '<i class="tz flag"></i>Tanzania'
    when "U.A.E"
      html = '<i class="ae flag"></i>U.A.E'
    when "Ukraine"
      html = '<i class="ua flag"></i>Ukraine'
    when "Uganda"
      html = '<i class="ug flag"></i>Uganda'
    when "Us Minor Islands"
      html = '<i class="um flag"></i>Us Minor Islands'
    when "United States"
      html = '<i class="us flag"></i>United States'
    when "Uruguay"
      html = '<i class="uy flag"></i>Uruguay'
    when "Uzbekistan"
      html = '<i class="uz flag"></i>Uzbekistan'
    when "Vatican City"
      html = '<i class="va flag"></i>Vatican City'
    when "Saint Vincent"
      html = '<i class="vc flag"></i>Saint Vincent'
    when "Venezuela"
      html = '<i class="ve flag"></i>Venezuela'
    when "British Virgin Islands"
      html = '<i class="vg flag"></i>British Virgin Islands'
    when "United Kingdom"
      html = '<i class="gb flag"></i>United Kingdom'
    when "Us Virgin Islands"
      html = '<i class="vi flag"></i>Us Virgin Islands'
    when "Vietnam"
      html = '<i class="vn flag"></i>Vietnam'
    when "Vanuatu"
      html = '<i class="vu flag"></i>Vanuatu'
    when "Wallis and Futuna"
      html = '<i class="wf flag"></i>Wallis and Futuna'
    when "Samoa"
      html = '<i class="ws flag"></i>Samoa'
    when "Yemen"
      html = '<i class="ye flag"></i>Yemen'
    when "Mayotte"
      html = '<i class="yt flag"></i>Mayotte'
    when "South Africa"
      html = '<i class="za flag"></i>South Africa'
    when "Zambia"
      html = '<i class="zm flag"></i>Zambia'
    when "Zimbabwe"
      html = '<i class="zw flag"></i>Zimbabwe'
    else
      html = 'Select Country'
    end

    return html
  end

  def get_usertype(name)
    case name
    when "Hardware Support"
      html = '<i class="fa fa-fw fa-gear" style="color:#5bc0de;font-size:13px;"></i>&nbsp;&nbsp;Hardware Support'
    when "Server Support"
      html = '<i class="fa fa-fw fa-th-list" style="color:#5bc0de;font-size:13px;"></i>&nbsp;&nbsp;Server Support'
    when "Domain support"
      html = '<i class="fa fa-fw fa-sitemap" style="color:#5bc0de;font-size:13px;"></i>&nbsp;&nbsp;Domain support'
    when "Customer Support Technician"
      html = '<i class="fa fa-fw fa-suitcase" style="color:#5bc0de;font-size:13px;"></i>&nbsp;&nbsp;Customer Support Technician'
    when "CyberAdvance Accounting"
      html = '<i class="fa fa-fw fa-twitter" style="color:#5bc0de;font-size:13px;"></i>&nbsp;&nbsp;CyberAdvance Accounting'
    when "Hardware Specialist"
      html = '<i class="fa fa-fw fa-cogs" style="color:#5bc0de;font-size:13px;"></i>&nbsp;&nbsp;Hardware Specialist'
    else
      html = 'Select Type'
    end

    return html
  end

  def get_duser(name)

    # dusers = DeviceUser.where(:device_name=>name)
    dusers = DeviceUser.where(:device_name=>name)
    return dusers
  end

  def get_checked(value)  
    if value == "1"
      return "checked"
    else
      return value
    end
  end

  def get_rnumber(value)
    return value.delete('-')
  end

  def get_countryfromip(value)
    if !value.nil?
      db = MaxMindDB.new('./GeoLite2-City.mmdb')
      ret = db.lookup(value)

      if ret.found?
        return ret.country.name
      else
        return 'Unresolved'
      end
    else
      return '---'
    end
  end

  def get_cityname(value)
    if !value.nil?
      db = MaxMindDB.new('./GeoLite2-City.mmdb')
      ret = db.lookup(value)

      if ret.found? && !ret.city.name.nil?
        return ret.city.name
      else
        return ''
      end
    else
      return '---'
    end
  end

  def get_continentfromip(value)
    if !value.nil?
      db = MaxMindDB.new('./GeoLite2-City.mmdb')
      ret = db.lookup(value)

      if ret.found? && !ret.city.name.nil?
        return ret.continent.name
      else
        return ''
      end
    else
      return '---'
    end 
  end

  def get_regcountryfromip(value)
    if !value.nil?
      db = MaxMindDB.new('./GeoLite2-City.mmdb')
      ret = db.lookup(value)

      if ret.found? && !ret.city.name.nil?
        return ret.registered_country.name
      else
        return ''
      end
    else
      return '---'
    end
  end

  def get_ip_info(ip_address)
    # https://geoip.maxmind.com/geoip/v2.1/insights/{ip_address}
    begin
      ip_info = Geoip2.insights(ip_address)
    rescue
      return "Something was taken on maxmind part"
    ensure
      return ip_info
    end
  end

  def get_deviceojbect_from_name(name)
    # ret = Device.where(:name=>name)
    ret = Device.find_by_name(name)

    if ret.nil?
      return nil
    else
      return ret
    end
  end

  def get_sortdirection(name)
    if !name.nil?
      tmp = name[name.mb_chars.length-2, name.mb_chars.length]

      if tmp == '_d'
        return '&nbsp;&#9661;'
      end

      if tmp == '_a'
        return '&nbsp;&#9651;'
      end

    end

    return ''
  end
  
end
