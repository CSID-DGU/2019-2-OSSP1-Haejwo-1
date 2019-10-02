# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, 'haejwo'
set :repo_url, 'git@github.com:CSID-DGU/2019-2-OSSP1-Haejwo-1.git'
set :repo_tree, 'haejwo-server'
set :deploy_to, '/home/deploy/haejwo'

append :linked_files, %w{config/master.key config/database.yml}
append :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

## 배포 후 쓰이지 않는 gem 정리
after 'deploy:published', 'bundler:clean'
