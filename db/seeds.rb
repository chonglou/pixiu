Setting.init = Time.now

root = User.new label: 'root', first_name: 'Admin', last_name: ENV['PIXIU_DOMAIN'], email: "root@#{ENV['PIXIU_DOMAIN']}", password: 'changeme'
root.skip_confirmation!
root.save!
root.add_role 'admin'
root.add_role 'root'

Setting['site_name_zh-CN']= '貔貅系统'
Setting['site_name_en']= 'Pixiu System'

Notice.create lang: 'zh-CN', content: '安装成功'
Notice.create lang: 'en', content: 'Install completed'

Document.create lang: 'zh-CN', name: 'contact', title: '联系我们', summary: '摘要', body: '详细信息'
Document.create lang: 'en', name: 'contact', title: 'Contact Us', summary: 'Summary', body: 'Details'
Document.create lang: 'zh-CN', name: 'help', title: '帮助中心', summary: '摘要', body: '详细信息'
Document.create lang: 'en', name: 'help', title: 'Help Center', summary: 'Summary', body: 'Details'

Setting.version = 'v20150118'
