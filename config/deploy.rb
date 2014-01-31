set :application, 'cricket_world'
set :repo_url, 'git@github.com:rajatsinghal/cricket_world.git'
set :rvm_ruby_version, '2.0.0'      # Defaults to: 'default'
set :rvm_type, :user   
set :default_environment, { 'PATH' => '$HOME/.rvm/bin/:$PATH' }

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute "cd #{release_path} && mkdir -p tmp"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :setup_db_yml do 
    on roles(:app) do
      execute "cp #{release_path}/config/database.yml.example  #{release_path}/config/database.yml"    
    end
  end

  task :migrate do 
    on roles(:app) do
      execute "cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=#{fetch(:stage)}"    
    end
  end

  task :assets_precompile do
    on roles(:app) do
      execute "cd #{release_path} && bundle exec rake assets:precompile RAILS_ENV=#{fetch(:stage)}"    
      execute "cd #{release_path} && cp app/assets/*.* public/assets/"
      execute "cd #{release_path} && mkdir public/javascripts"
      execute "cd #{release_path} && cp app/assets/javascripts/jquery.fancybox.pack.js public/javascripts/"
      execute "cd #{release_path} && cp app/assets/javascripts/jquery.fancybox-thumbs.js public/javascripts/"
    end
  end

  task :bundler do
    on roles(:app) do
      #execute "cd #{release_path} && bundle install --without development test"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before "deploy:setup_db_yml", "deploy:bundler"
  before "deploy:migrate", "deploy:setup_db_yml"
  after "deploy:migrate", 'deploy:assets_precompile'

  before :restart, "deploy:migrate"
  after :finishing, 'deploy:cleanup'

end
