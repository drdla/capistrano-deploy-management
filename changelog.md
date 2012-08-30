- 0.1.34 / 0.1.35 / 0.1.36
  start unicon using bundle exec

- 0.1.23 / 0.1.24 / 0.1.25 / 0.1.26 / 0.1.27 / 0.1.28 / 0.1.28 / 0.1.30 / 0.1.31 / 0.1.32 / 0.1.32
  work in progress: only precompile assets if any assets have changed

- 0.1.21 / 0.1.22
  attempt to speed up bundle install using --local flag // reverted, because some gems are OS-specific and make bundle install fail

- 0.1.19 / 0.1.20
  improved unicorn restart

- 0.1.17 / 0.1.18
  removed rails_assets recipes, as they are included in capistrano by default now; just load 'deploy/assets' in your Capfile

- 0.1.13 / 0.1.14 / 0.1.15 / 0.1.16
  fix puma configuration

- 0.1.10 / 0.1.11 / 0.1.12
  fixed unicorn and puma recipe: only stop server, if pid file exists

- 0.1.9
  updated puma recipe

- 0.1.3 / 0.1.4 / 0.1.5 / 0.1.6  / 0.1.7 / 0.1.8
  unicorn recipe: only stop unicorn, if pid file exists

- 0.1.2
  fixed bug in unicorn recipe

- 0.1.1
  integrated / updated further recipes:
  - unicorn
  - rails_assets
  - puma # yet untested
  code formatting

- 0.1.0
  initial commit;
  gem forked from https://github.com/lest/capistrano-deploy and adjusted paths