case Setting.version
  when 'v20150118'
  else
    Setting.init = Time.now

    root = User.new label: 'root', first_name: 'Admin', last_name: ENV['PIXIU_DOMAIN'], email: "root@#{ENV['PIXIU_DOMAIN']}", password: 'changeme'
    root.skip_confirmation!
    root.save!
    root.add_role 'admin'
    root.add_role 'root'

    n1 = Notice.create lang: 'zh-CN', content: '安装成功'
    n2 = Notice.create lang: 'en', content: 'Install completed'
    nl= SecureRandom.uuid
    Locale.create flag: :notice, uid: nl, lang: 'zh-CN', tid: n1.id
    Locale.create flag: :notice, uid: nl, lang: 'en', tid: n2.id

    Setting.version = 'v20150118'
end