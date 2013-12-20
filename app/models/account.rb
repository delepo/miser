class Account < ActiveRecord::Base
  belongs_to :bank
  validates :name, presence: true, uniqueness: true
end
