部署
---------
## 服务器(以ubuntu为例)
### 依赖包
  sudo apt-get install pwgen nodejs
  npm install bower
### ruby环境
 * rbenv https://github.com/sstephenson/rbenv
 * rbenv-vars  https://github.com/sstephenson/ruby-vars
 * ruby-build https://github.com/sstephenson/ruby-build


    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/ruby-vars
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    # 重新登录 使.bashrc生效
    rbenv install 2.2.0
    git clone git@github.com:chonglou/pixiu.git
    cd pixiu
    gem install bundler # 如果发生错误 一般是缺失相应的lib文件 补上即可
    bundle install
    rbenv rehash


## 本地
### 部署
  cap production deploy


## 测试
浏览器打开 https://你的域名
