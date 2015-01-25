class Contact < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user

  def logo
    Attachment.find(self.logo_id).avatar.finger.url if self.logo_id
  end
  def to_html
    "<p>Qq: #{self.qq}<br>Email: #{self.email}<br>Skype:#{self.skype}</p>"
  end
end
