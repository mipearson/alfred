# environment 'production' do
#   set :myapp_test_server,  'A'
#   set :myapp_dir, '/web/myapp'
#   set :myapp_servers, {
#     'A' => ['myapp01a', 'myapp02a', 'myapp03a'],
#     'B' => ['myapp01b', 'myapp02b', 'myapp03b']
#   }
#   
#   set :restart_command, {
#     'A' => '/usr/sbin/apachectlA restart'
#     'B' => '/usr/sbin/apachectlB restart'
#   }
# end

class Environment
end

class ProductionEnvironment < Environment
  def rsearch_test_server
    'A'
  end
  
  def rsearch_dir
    '/web/myapplestate'
  end
  
  def myapp_servers server_set
    (0..10).map {|n| "myapp#{n}#{server_set}"}
  end
  
  def restart_command server_set
    "/usr/sbin/apachectl#{server_set} restart"
  end
end
      
