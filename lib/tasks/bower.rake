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
    unless Dir.exist?(d)
      FileUtils.mkdir_p d
      puts `cd #{s} && npm install && grunt --server=jsp --encode=utf8`
      %w(dialogs lang themes third-party ueditor.all.min.js ueditor.parse.min.js).each{|p| FileUtils.cp_r "#{s}/dist/utf8-jsp/#{p}", "#{d}/#{p}"}
    end
  end

end

task 'assets:precompile' => 'bower:ueditor'


