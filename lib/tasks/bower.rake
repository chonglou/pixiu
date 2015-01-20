namespace :bower do
  desc 'Install 3rd package'
  task :install do
    puts `bower install -p`

  end

  desc 'List 3rd package'
  task :list do
    puts `bower list`
  end

  desc 'Build UEditor'
  task :ueditor do
    p = "#{Rails.root}/vendor/assets/bower_components/ueditor"
    if Dir.exist?(p) && !Dir.exist?("#{p}/dist/utf8-jsp")
      puts `cd #{p} && npm install && grunt --server=jsp --encode=utf8`
    end
  end

end

task 'assets:precompile' => 'bower:ueditor'


