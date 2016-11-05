require 'sinatra/base'
require 'json'
require 'yaml'
require_relative 'workflow'

module Eustia
  class App < Sinatra::Base
    post '/payload' do
      payload = JSON.parse(request.body.read)
      if workflow = workflow_for(payload)
        workflow.run
      end
    end

    def verify_signature(payload_body)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['SECRET_TOKEN'], payload_body)
      return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end

    def session_for(payload)
      event = request.env['HTTP_X_GITHUB_EVENT']
      repo = payload.dig('repository', 'full_name')
      branch = payload['ref']&.match(/refs\/heads\/(.+$)/)&.[](1)
      gh_webhook = YAML.load_file(File.expand_path(Eustia.configuration.github_webhook))
      gh_webhook.dig(repo, event, branch)
    end

    def workflow_for(payload)
      session_data = session_for(payload)
      session = session_data&.[]('session')
      return unless session

      if klass = session_data['custom_klass']
        Object.const_get(klass).new(session, payload)
      else
        Workflow.new(session)
      end
    end
  end
end
