SiteInfo.version!
Setting.init = Time.now

root = User.new label:'root', first_name:'Admin', last_name:ENV['PIXIU_DOMAIN'], email:"root@#{ENV['PIXIU_DOMAIN']}", password:'changeme'
root.skip_confirmation!
root.save!
root.add_role 'admin'
root.add_role 'root'

Notice.create lang:'zh-CN', content:'安装成功'
Notice.create lang:'en', content:'Install completed'