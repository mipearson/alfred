class DSL
  attr_reader :aplications, :sources, :vars
  
  def self.instance
    @@me ||= new
  end
  
  def initialize
    @applications = {}
    @sources = {}
    @vars = {}
  end
  
	def run(file)
		eval(File.read(file), binding)
	end

	def application(name, &block)
	  builder = Application.new(name)
	  builder.instance_eval(&block)
	  @applications[name] = builder
	  builder
	end
	
	def source(&block)
	  builder = Source.new
	  builder.instance_eval(&block)
	  @sources = builder.sources
	  builder
	end

	class MyBuilder
	  def initialize(name)
	    @name = name
	    @git = []
	  end
	    
	  def git(path)
	    @git << path
	  end
	end
end

#$ deploy rsearch version1.2