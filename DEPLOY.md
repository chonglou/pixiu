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
    sudo apt-get install pwgen git
    sudo apt-get install nginx nodejs mysql-server memcached redis-server elasticsearch
    sudo apt-get install libffi-dev zlib1g-dev libssl-dev
    sudo apt-get install libmysqlclient-dev
    sudo apt-get clean
    sudo npm install -g bower
    sudo ln -s /usr/bin/nodejs /usr/bin/node
    mysql_secure_installation

### SSL证书安装
#### 制作（可选）

    mkdir /tmp/ssl
    cd /tmp/ssl
    openssl genrsa -out key.pem 2048 
    openssl req -new -key key.pem  -subj "/C=US/ST=California/L=Goleta/O=pixiu/CN=0-dong.com" -out cert.csr -text 
    openssl x509 -req -in cert.csr -sha512 -days 3650  -signkey key.pem -out cert.pem -text


#### 安装

    sudo mkdir -p /etc/nginx/ssl
    cd /etc/nginx/ssl
    sudo cp /tmp/ssl/pixiu-key.pem ./
    sudo cp /tmp/ssl/pixiu-cert.pem ./
    sudo chmod 400 pixiu-key.pem
    sudo chmod 444 pixiu-cert.pem
    rm -r /tmp/ssl

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
### 部署
    cap production puma:nginx_config
    cap production puma:config
    cap production deploy


## 测试
浏览器打开 https://你的域名
