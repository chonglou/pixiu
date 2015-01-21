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

  desc 'Build third-part libary'
  task :third do
    bower_home = "#{Rails.root}/vendor/assets/bower_components"
    third_home = "#{Rails.root}/public/3rd"
    download_home = "#{Rails.root}/tmp/downloads"

    #----------- UEditor------
    s = "#{bower_home}/ueditor"
    d = "#{third_home}/ueditor"

    unless Dir.exist?(download_home)
      FileUtils.mkdir_p download_home
    end

    unless Dir.exist?(d)
      FileUtils.mkdir_p d
      puts `cd #{s} && npm install && grunt --server=jsp --encode=utf8`
      %w(dialogs lang themes third-party ueditor.all.min.js ueditor.parse.min.js).each { |p| FileUtils.cp_r "#{s}/dist/utf8-jsp/#{p}", "#{d}/#{p}" }

      %w(emotion list).each do |f|
        unless File.exist?("#{download_home}/ueditor-#{f}.zip")
          puts `cd #{download_home} && wget http://ueditor.baidu.com/build/build_down.php?n=ueditor-#{f}.zip -O ueditor-#{f}.zip`
        end
        unless Dir.exist?("#{download_home}/ueditor-#{f}")
          puts `cd #{download_home} && unzip ueditor-#{f}.zip -d ueditor-#{f}`
        end
      end

      puts `cp -av #{download_home}/ueditor-emotion/images/* #{d}/dialogs/emotion/images/`
      puts `cp -av #{download_home}/ueditor-list/ueditor-list #{d}/themes/`

    end

    #-------JStree-------
    # s = "#{bower_home}/jstree"
    # d = "#{third_home}/jstree"
    # unless Dir.exists?(d)
    #   `cp -av #{s}/../jstree/dist #{d}`
    # end

  end

end

task 'assets:precompile' => 'bower:ueditor'


