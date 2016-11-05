module Eustia
  class DigdagClient
    attr_reader :endpoint

    def initialize
      @endpoint = Eustia.configuration.digdag_endpoint
    end

    def push project_dir
      project = basenameOf(project_dir)
      %x( digdag push #{project} --project #{project_dir} #{endpoint_option if endpoint} )
    end

    def start project, workflow
      %x( digdag start #{project} #{workflow} --session now #{endpoint_option if endpoint} )
    end

    private

    def basenameOf dir
      File.basename dir
    end

    def endpoint_option
      "-e #{endpoint}"
    end
  end
end
