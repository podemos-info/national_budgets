# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server ENV['PRODUCTION_SERVER_HOST'], port: ENV['PRODUCTION_SERVER_PORT'], user: ENV['PRODUCTION_USER'], roles: %w[app db web]

set :rails_env, :production
set :user, ENV['PRODUCTION_USER']

set :branch, :master

after 'deploy:publishing', 'systemd:puma:restart'

