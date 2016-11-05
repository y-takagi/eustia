module Eustia
  class Workflow
    attr_reader :session, :client

    def initialize(session, payload={})
      @session = session
      @payload = payload
      @client = Eustia::DigdagClient.new
    end

    def run
      return if skip?
      project, workflow = session.split('/')
      client.start(project, workflow)
    end

    def skip?
      false
    end
  end
end
