class UserMailer < ApplicationMailer

  def add_attachment
    attachments.inline["logo.png"] = 
    {
      :data => File.read("#{Rails.root}/app/assets/images/logo1.png"),
      :mime_type => "image/png",
      :enconding => "base64"
    }
  end

  def caccount_email(account_info)
    add_attachment
    @url  = 'https://adcp.cyberadvance.com/'
    @account_info = account_info
    mail(to: @account_info.email_addr, subject: 'Your account is under review at the moment!')
  end 

  def cdevice_email(device_info)
    add_attachment
    @url  = 'https://adcp.cyberadvance.com/'
    @device_info = device_info

    tmp = Account.where(:email_addr=>device_info.owner)
    @device_id = tmp[0].id.to_s

    mail(to: @device_info.owner, subject: 'Your device is under review at the moment!')
  end 

  def register_email(register_info)
    add_attachment
    @url  = 'https://adcp.cyberadvance.com/'
    @register_info = register_info
    mail(to: @register_info.pemail, subject: 'Your account was registerd successfully!')
  end   

  def quick_email(email, subject, content)
    add_attachment
    @url  = 'https://adcp.cyberadvance.com/'
    @content = content
    @subject = subject
    mail(to: email, subject: subject)
  end   

end
