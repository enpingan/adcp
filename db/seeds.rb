# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
suser = User.new(:email => 'cyberadvance@admin.com', :password => 'cyberadvance123', :password_confirmation => 'cyberadvance123', :username=>'CyberAdvance', :pwd=>'Y3liZXJhZHZhbmNlMTIz', :account_type=>'god')
suser.save
