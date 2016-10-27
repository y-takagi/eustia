class Workflow
  def initialize(session, payload={})
    @session = session
    @payload = payload
  end

  def run
    return if skipFlow?
    %x( digdag start #{workflow} --session now -e #{ENV['DIGDAG_ENDPOINT']} )
  end

  def skipFlow?
    false
  end

  private

  def workflow
    @session.split('/').join(' ')
  end
end
