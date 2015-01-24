class Contact < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user

  def logo
    Attachment.find(self.logo_id) if self.logo_id
  end
end
