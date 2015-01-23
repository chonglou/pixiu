namespace :rails do
  desc 'Invoke rake task'
  task :task, :name do
    on roles(ENV['ROLE'].to_sym) do
      within current_path do
        with rails_env: :production do
          #execute('uname -a')
          rake (ENV['TASK'] || '-T')
        end
      end
    end
  end
end
