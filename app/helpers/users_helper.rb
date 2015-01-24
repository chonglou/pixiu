module UsersHelper
  def top_waiters(len)
    waiters=[]
    User.with_any_role(:seller, :assistant).each do |u|
      contact = u.contact
      if contact && contact.logo
        title = ''
        if u.is_assistant?
          title = t 'helpers.label.role.assistant'
        end

        if u.is_seller?
          title << "#{' & ' unless title.empty?}#{t('helpers.label.role.seller')}"
        end

        waiters << {
            img: contact.logo.avatar.url,
            url: show_user_by_uid(uid:u.uid),
            title: title,
            summary: contact.details
        }
      end
    end

    if waiters.empty?
      1.upto(3) do |i|
        waiters << {
            img: 'data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==',
            url: '#',
            title: "User #{i}",
            summary: "<p>Contact #{i}</p>"
        }
      end
    end
    waiters
  end
end