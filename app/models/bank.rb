class Bank < ActiveRecord::Base
   validates :name, presence: true
   validates :name, uniqueness: true 
   validates :bank_code, uniqueness: true 
end
