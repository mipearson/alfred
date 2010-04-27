# this is a DSL myapp, anonymized from a production usecase, showing
# deployment to an A/B shared server system from multiple sources. 
# note that in this myapp that while there are many servers to restart,
# the code is deployed to a shared drive.
application 'myapp' do
  server_set = environment.myapp_test_server
  cgi_bin_dir = environment.myapp_dir + '/cgi_bin' + server_set
  web_dir = environment.myapp_dir + '/web'

  # remove some paths in the destination
  ['doc', 'funcs-myapp', 'rw', 'templates'].each do |path| 
    rm_rf cgi_bin_dir + '/' + path
  end

  export 'myapp' do
    # grab our helper and run some Example-specific transformations
    myapp = helper(Example)
    myapp.set_revision
    myapp.compact_stylesheets
    myapp.compact_templates
    myapp.version_files
    # discard some non-production code
    ['bin', 't', 'build', 'myapp.conf'].each do |path|
      discard path
    end
    chown 'www'
    deploy 'web', web_dir
    deploy 'myapp', cgi_bin_dir
  end

  export 'myapp_sharedlib' do
    chown 'www'
    deploy 'lib', cgi_bin_dir + '/lib'
  end

  run environment.restart_command(server_set), :on => environment.myapp_servers(server_set)

  notify :method => 'email', :to => environment.admin_email_address
end
