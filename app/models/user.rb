class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password
  after_destroy :ensure_a_user_remains
  
  private
  
  def ensure_a_user_remains
    if User.count.zero?
      raise I18n.t('activerecord.errors.models.user.last_user')
    end
  end
end
