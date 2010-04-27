require 'rubygems'
require 'temp_dir'

class Application
  include Runner
  
  def initialize(name)
    @name = name
    @git = []
  end
  
  def rm_rf path
    run 'rm -rf ' + path
  end
  
  def export(source, &block)
    builder = Export.new(source)
    builder.instance_eval(&block)
  end
  
  def notify
    run 'email some shit'
  end
  
  def environment
    @environment ||= ProductionEnvironment.new
  end

  class Export
    attr_reader :source
    include Runner
    
    def initialize(_source)
      raise "Unknown source #{_source}" unless DSL.instance.sources.include? _source
      @source = DSL.instance.sources[_source]
      @tempdir = TempDir.create(:basename => "#{_source}.export")
      ObjectSpace.define_finalizer(self, lambda { File.rm_rf(@tempdir)})
      source.export('master', @tempdir)
    end
    
    def method_missing *args
      run args.join(" ")
    end
  end
  
end



#$ deploy rsearch version1.2