class AddAvatarToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :avatar, :string
  end
end
