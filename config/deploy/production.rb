set :deploy_to, "/home/apps/#{fetch(:application)}"
set :rails_env, 'production'
set :ssh_options, {
  user: 'apps',
  forward_agent: true
}

servers = ['18.181.90.202']

shadow_server = '18.181.90.202'
role :app,                servers
role :web,                servers + [shadow_server]
role :db,                 shadow_server
role :worker,             shadow_server
role :assets_sync_server, shadow_server
