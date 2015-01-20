require 'fileutils'

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
    s = "#{Rails.root}/vendor/assets/bower_components/ueditor"
    d = "#{Rails.root}/public/3rd/UEditor"
    t = "#{Rails.root}/tmp/downloads"

    unless Dir.exist?(t)
      FileUtils.mkdir_p t
    end

    unless Dir.exist?(d)
      FileUtils.mkdir_p d
      puts `cd #{s} && npm install && grunt --server=jsp --encode=utf8`
      %w(dialogs lang themes third-party ueditor.all.min.js ueditor.parse.min.js).each { |p| FileUtils.cp_r "#{s}/dist/utf8-jsp/#{p}", "#{d}/#{p}" }

      %w(emotion list).each do |f|
        unless File.exist?("#{t}/ueditor-#{f}.zip")
          puts `cd #{t} && wget http://ueditor.baidu.com/build/build_down.php?n=ueditor-#{f}.zip -O ueditor-#{f}.zip`
        end
        unless Dir.exist?("#{t}/ueditor-#{f}")
          puts `cd #{t} && unzip ueditor-#{f}.zip -d ueditor-#{f}`
        end
      end

      puts `cp -av #{t}/ueditor-emotion/images/* #{d}/dialogs/emotion/images/`
      puts `cp -av #{t}/ueditor-list/ueditor-list #{d}/themes/`

    end

  end

end

task 'assets:precompile' => 'bower:ueditor'


