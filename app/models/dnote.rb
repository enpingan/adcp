class Dnote < ActiveRecord::Base
  belongs_to :devices
  
  self.table_name = "Dnotes"
end
