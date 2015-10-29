class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :authentication_keys=>[:login]

  # attr_accessor :login

  # def login=(login)
  #   @login = login
  # end

  # def login
  #   @login || self.username || self.email
  # end

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup

  #   if login = conditions.delete(:login)
  #     where(conditions.to_h).where(["lower(username)=:value OR lower(email)=:value",{:value=>login.downcase}]).first
  #   else
  #     if conditions[:username].nil?
  #       where(conditions.to_h).first
  #     else
  #       where(username:conditions[:username]).first
  #     end
  #   end
  # end
  self.table_name = "Users"
end
