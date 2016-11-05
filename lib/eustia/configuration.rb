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
      @github_webhook = 'webhook.yml'
      @digdag_projects = []
    end
  end
end
