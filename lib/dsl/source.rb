class Source
  attr_reader :sources
  
  def initialize
    @sources = {}
  end
  
  def git name, uri
    @sources[name] = GitSource.new(uri)
  end
  
  class GitSource
    include Runner
    attr_reader :uri

    def kind
      :git
    end

    def initialize(uri)
      @uri = uri
    end

    def export revision, destination
      run "git archive --remote_path=#{uri} #{revision} | tar -xf- -C #{destination}"
    end
  end
end  

