module Eustia
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration) if block_given?
    end
  end

  class Configuration
    attr_accessor :github_webhook, :digdag_projects, :digdag_endpoint

    def initialize
      @digdag_projects = []
    end

    def github_webhook= path
      @github_webhook = YAML.load_file(File.expand_path(path))
    end
  end
end
