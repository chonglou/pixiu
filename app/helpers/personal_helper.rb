module PersonalHelper
  def personal_right_nav_links
    [
        {url: edit_user_registration_url, name: t('links.personal.profile')},

        {url: personal_contact_url, name: t('links.personal.contact')}
    ]
  end
  def left_nav_links
    ab = Ability.new(current_user)

    links = [{url: edit_user_registration_url, name: t('links.personal.profile')}]
    links << {url: admin_site_info_url, name: t('links.admin.site.index')} if ab.can?(:manage, :site)
    links << {url: admin_notices_url, name: t('links.admin.notice.index')} if ab.can?(:manage, :notice)
    links << {url: admin_documents_url, name: t('links.admin.document.index')} if ab.can?(:manage, :document)
    links << {url: admin_products_url, name: t('links.admin.product.index')} if ab.can?(:manage, :product)
    links << {url: admin_tags_url, name: t('links.admin.tag.index')} if ab.can?(:manage, :tag)
    links << {url: attachments_manage_url, name: t('links.attachments.manage')}

    links
  end

  def personal_bar
    user = current_user
    if user
      label = t('links.welcome', username: user.label, logo: email2logo(user.email, 18))
      links={
          edit_user_registration_path => t('links.personal.index'),
          destroy_user_session_path => t('links.personal.sign_out')
      }
    else
      label = t('links.personal.register_or_signin')
      links={
          new_user_session_path => t('links.personal.sign_in'),
          new_user_registration_path => t('links.personal.register'),
          new_user_password_path => t('links.personal.reset_password'),
          new_user_confirmation_path => t('links.personal.active'),
          new_user_unlock_path => t('links.personal.unlock')
      }
    end
    {label: label, links: links}
  end

end
