namespace :bower do
  desc 'Install 3rd package'
  task :install do
    puts `bower install -p`
    puts `cd #{Rails.root}/vendor/assets/bower_components/ueditor && npm install && grunt --server=jsp --encode=utf8`
  end

  desc 'List 3rd package'
  task :list do
    puts `bower list`
  end

end

#task 'assets:precompile' => 'bower:install'


