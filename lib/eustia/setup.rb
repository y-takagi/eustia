module Eustia
  class Setup
    attr_reader :options, :client

    def self.execute(options={})
      new(options).run
    end

    def initialize options
      @options = options
      @client = Eustia::DigdagClient.new
    end

    def run
      register_workflow
      start_server
    end

    def register_workflow
      Eustia.configuration.digdag_projects.each do |project|
        client.push(File.expand_path(project))
      end
    end

    def start_server
      Eustia::App.run!(options)
    end
  end
end
