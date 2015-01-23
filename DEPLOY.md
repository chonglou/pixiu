部署
---------
## 服务器(以ubuntu为例)

###设置deploy用户
    useradd -s /bin/bash -m deploy
    passwd -l deploy
    echo 'deploy ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/deploy
    chmod 400 /etc/sudoers.d/deploy
    su - deploy
    mkdir .ssh
    chmod 700 .ssh
    cat /tmp/id_rsa.pub >> .ssh/authorized_keys

### 测试deploy用户
    ssh deploy@YOUR_HOST

### 依赖包

    wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
    sudo add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"
    sudo apt-get update
    sudo apt-get install build-essential
    sudo apt-get install pwgen git imagemagick
    sudo apt-get install nginx nodejs mysql-server memcached redis-server elasticsearch
    sudo apt-get install libffi-dev zlib1g-dev libssl-dev
    sudo apt-get install libmysqlclient-dev
    sudo apt-get clean
    sudo npm install -g bower
    sudo npm install -g grunt-cli
    sudo ln -s /usr/bin/nodejs /usr/bin/node
    mysql_secure_installation

### 数据库设置
    CREATE DATABASE pixiu CHARACTER SET utf8;
    GRANT ALL PRIVILEGES ON pixiu.* TO 'pixiu'@'localhost' IDENTIFIED BY 'changeme';
    FLUSH PRIVILEGES;

### ruby环境

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

### 目录设置
    sudo mkdir -p /var/www/pixiu
    sudo chown -R deploy:deploy /var/www/pixiu
    cd /var/www/pixiu
    mkdir -p shared/config
    cd shared
    # upload your config files(config/sidekiq.yml .rbenv-vars)


## 本地

### 上传nginx配置
    cap production puma:nginx_config
### 初始化数据库
    cap production deploy:migrate
    ROLE=db TASK=db:seed cap production rails:task
    ROLE=web TASK=nginx:certs cap production rails:task(可选，你也可以上传自己的数字证书到/etc/nginx/ssl)
### 部署
    cap production deploy


## 测试
浏览器打开 https://你的域名
