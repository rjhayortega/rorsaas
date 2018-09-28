require 'mina/rails'
require 'mina/git'
# require 'mina_sidekiq/tasks'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'houseq'
set :domain, '52.39.2.49'
set :deploy_to, '/var/www/houseq'
set :repository, 'git@github.com:joshuawhitesm/HouseQ2.git'
set :branch, 'master'

# Optional settings:
set :user, 'ec2-user'          # Username in the server to SSH to.

set :term_mode, nil
# set :port, '22'           # SSH port number.
# set :forward_agent, true     # SSH forward_agent.

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('somedir')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_dirs, fetch(:shared_dirs, []).push(
  "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/uploads", "public/packs", "vendor/bundle"
)
set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml',
  'config/secrets.yml'
)

# set :sidekiq, 'sidekiq'


task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'
  invoke :'rvm:use', 'ruby-2.4.1'
  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0}
  # command %(mkdir -p "#{fetch(:deploy_to)}/shared/pids/")
  # command %(mkdir -p "#{fetch(:deploy_to)}/shared/log/")
end

desc "Deploys the current version to the server."

task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    
    invoke :'git:clone'

    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'sidekiq:quiet'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
      # invoke :'sidekiq:restart'
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs

namespace :delayed_job do
  set :delayed_job, 'bin/delayed_job'
  set :delayed_job_pid_dir, 'tmp/pids'
  set :delayed_job_processes, 1
  set :delayed_job_additional_params, ''
  # set :shared_dirs, fetch(:shared_dirs, []).push(fetch(:delayed_job_pid_dir))
  set :delayed_job_env,       -> { fetch(:rails_env, 'production') }

  desc 'Stop delayed_job'
  task stop: :environment do
    comment 'Stop delayed_job'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:delayed_job_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} stop --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end

  desc 'Start delayed_job'
  task start: :environment do
    comment 'Start delayed_job'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:delayed_job_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} start -n #{fetch(:delayed_job_processes)} --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end

  desc 'Restart delayed_job'
  task restart: :environment do
    comment 'Restart delayed_job'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:delayed_job_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} restart -n #{fetch(:delayed_job_processes)} --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end

  desc 'delayed_job status'
  task status: :environment do
    comment 'Delayed job Status'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:delayed_job_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} status --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end
end



namespace :puma do
  set :web_server, :puma

  set :puma_role,      -> { fetch(:user) }
  set :puma_env,       -> { fetch(:rails_env, 'production') }
  set :puma_config,    -> { "#{fetch(:shared_path)}/config/puma.rb" }
  set :puma_socket,    -> { "#{fetch(:shared_path)}/tmp/sockets/puma.sock" }
  set :puma_bind,    -> { "tcp://0.0.0.0:8081" }
  # set :puma_bind,    -> { "unix://#{fetch(:shared_path)}/tmp/sockets/puma.sock" }
  set :puma_state,     -> { "#{fetch(:shared_path)}/tmp/sockets/puma.state" }
  set :puma_pid,       -> { "#{fetch(:shared_path)}/tmp/pids/puma.pid" }
  set :puma_cmd,       -> { "#{fetch(:bundle_prefix)} puma" }
  set :pumactl_cmd,    -> { "#{fetch(:bundle_prefix)} pumactl" }
  set :pumactl_socket, -> { "#{fetch(:shared_path)}/tmp/sockets/pumactl.sock" }
  set :puma_root_path, -> { fetch(:current_path) }

  desc 'Start puma'
  task :start => :environment do
    puma_port_option = "-p #{fetch(:puma_port)}" if set?(:puma_port)

    comment "Starting Puma..."
    command %[
      if [ -e "#{fetch(:pumactl_socket)}" ]; then
        echo 'Puma is already running!';
      else
        if [ -e "#{fetch(:puma_config)}" ]; then
          cd #{fetch(:puma_root_path)} && #{fetch(:puma_cmd)} -q -d -e #{fetch(:puma_env)} -C #{fetch(:puma_config)} --control 'unix://#{fetch(:pumactl_socket)}'
        else
          cd #{fetch(:puma_root_path)} && #{fetch(:puma_cmd)} -q -d -e #{fetch(:puma_env)} -b "#{fetch(:puma_bind)}" #{puma_port_option} -S #{fetch(:puma_state)} --pidfile #{fetch(:puma_pid)} --control 'unix://#{fetch(:pumactl_socket)}'
        fi
      fi
    ]
    command "sleep 2"
  end

  desc 'Stop puma'
  task stop: :environment do
    comment "Stopping Puma..."
    pumactl_command 'stop'
    command %[rm -f '#{fetch(:pumactl_socket)}']
  end

  desc 'Restart puma'
  task restart: :environment do
    comment "Restart Puma...."
    pumactl_command 'restart'
  end

  desc 'Restart puma (phased restart)'
  task phased_restart: :environment do
    comment "Restart Puma -- phased..."
    pumactl_command 'phased-restart'
  end

  desc 'Restart puma (hard restart)'
  task hard_restart: :environment do
    comment "Restart Puma -- hard..."
    invoke 'puma:stop'
    invoke 'puma:start'
  end

  desc 'Get status of puma'
  task status: :environment do
    comment "Puma status..."
    pumactl_command 'status'
  end

  def pumactl_command(command)
    cmd =  %{
      if [ -e "#{fetch(:pumactl_socket)}" ]; then
        if [ -e "#{fetch(:puma_config)}" ]; then
          cd #{fetch(:puma_root_path)} && #{fetch(:pumactl_cmd)} -F #{fetch(:puma_config)} #{command}
        else
          cd #{fetch(:puma_root_path)} && #{fetch(:pumactl_cmd)} -S #{fetch(:puma_state)} -C "unix://#{fetch(:pumactl_socket)}" --pidfile #{fetch(:puma_pid)} #{command}
        fi
      else
        echo 'Puma is not running!';
      fi
    }
    command cmd
  end
end





set :whenever_name, -> { "#{fetch(:domain)}_#{fetch(:rails_env)}" }

namespace :whenever do
  desc 'Clear crontab'
  task clear: :environment do
    comment "Clear contrab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --clear-crontab #{fetch(:whenever_name)} --set 'environment=#{fetch(:rails_env)}&path=#{fetch(:current_path)}'"
    end
  end

  desc 'Update crontab'
  task update: :environment do
    comment "Update crontab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --update-crontab #{fetch(:whenever_name)} --set 'environment=#{fetch(:rails_env)}&path=#{fetch(:current_path)}'"
    end
  end

  desc 'Write crontab'
  task write: :environment do
    comment "Write crontab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --write-crontab #{fetch(:whenever_name)} --set 'environment=#{fetch(:rails_env)}&path=#{fetch(:current_path)}'"
    end
  end
end