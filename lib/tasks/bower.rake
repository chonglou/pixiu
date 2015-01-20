namespace :bower do
  desc 'install'
  task :install do
    `bower install -p`
  end

  desc 'install'
  task :list do
    `bower list`
  end

  desc 'Build UEditor'
  task :ueditor do
    puts `cd #{Rails.root}/vendor/assets/bower_components/ueditor && npm install && grunt --server=jsp --encode=utf8`
  end
end

#task 'bower:install' => 'db:migrate'

task :aaa1 do
  puts 'aaa'
end

