module PersonalHelper
  def personal_ctl_panel
    user = current_user
    links = [{url:edit_user_registration_url, name:t('links.personal.profile')}]
    if user.is_admin?
      links << {url: admin_site_info_url, name: t('links.admin.site.info')}
      links << {url: documents_url, name: t('links.document.index')}
    end
    links
  end

  def personal_bar
    user = current_user
    if user
      label = t('links.welcome', username: user.label, logo: email2logo(user.email, 18))
      links={
          personal_path => t('links.personal.index'),
          edit_user_registration_path => t('links.personal.profile'),
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
