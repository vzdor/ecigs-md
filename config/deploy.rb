set :application, "ecigs"
set :repository,  "git@git.assembla.com:ecigs-md.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "gw"                          # Your HTTP server, Apache/etc
role :app, "gw"                          # This may be the same as your `Web` server
role :db,  "gw", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

after 'deploy:symlink', 'deploy:symlink_config'

after 'deploy:symlink', 'deploy:rm_css_js_bundles'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
  task :symlink_config do
    run "ln -nfs #{shared_path}/ecigs.yml #{release_path}/config/configatron"
  end

  task :rm_css_js_bundles do
    run "rm -f #{shared_path}/system/all.js"
    run "rm -f #{shared_path}/system/all.css"
  end
end
