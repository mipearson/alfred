module Runner
  def run command, opts = {}
    if opts[:on]
      opts[:on].each do |server|
        run "ssh #{server} #{command}"
      end
    else
      puts ">> " + command
    end
  end
end