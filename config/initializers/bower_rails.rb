BowerRails.configure do |bower_rails|
  # Tell bower-rails what path should be considered as root. Defaults to Dir.pwd
  # bower_rails.root_path = Dir.pwd

  # Invokes rake bower:install before precompilation. Defaults to false
  bower_rails.install_before_precompile = true

  # Invokes rake bower:resolve before precompilation. Defaults to false
  # bower_rails.resolve_before_precompile = true

  # Invokes rake bower:clean before precompilation. Defaults to false
  # bower_rails.clean_before_precompile = true
  
  # Invokes rake bower:install:deployment instead rake bower:install. Defaults to false
  # bower_rails.use_bower_install_deployment = true
end

# Bower asset paths
Rails.root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
  Rails.application.config.sass.load_paths << bower_path
  Rails.application.config.assets.paths << bower_path
end
# Precompile Bootstrap fonts
Rails.application.config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
# Minimum Sass number precision required by bootstrap-sass
::Sass::Script::Number.precision = [8, ::Sass::Script::Number.precision].max

