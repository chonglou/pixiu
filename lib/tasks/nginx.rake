namespace :nginx do
  desc 'generate openssl certs'
  task :certs do
    path = '/etc/nginx/ssl'
    name = "pixiu_#{Rails.env}"
    unless File.exists?(path)
      `sudo mkdir -p #{path}`
      `cd #{path} && sudo openssl genrsa -out #{name}.pem 2048`
      `cd #{path} && sudo openssl req -new -key #{name}_key.pem  -subj "/C=US/ST=California/L=Goleta/O=pixiu/CN=0-dong.com" -out #{name}.csr -text`
      `cd #{path} && sudo openssl x509 -req -in #{name}.csr -sha512 -days 3650  -signkey #{name}_key.pem -out #{name}_cert.pem -text`
      `cd #{path} && sudo chmod 400 #{name}_key.pem && sudo chmod 444 #{name}_cert.pem`
    end
  end
end
