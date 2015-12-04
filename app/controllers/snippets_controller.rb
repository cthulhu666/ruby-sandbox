class SnippetsController < ApplicationController
  def create
    code = params[:code]
    spec = params[:spec]
    gems = ['activesupport']

    renderer = ERB.new(File.read('lib/templates/spec.rb.erb'))
    output = renderer.result(binding)

    c = Sandbox::Container.new(
        snippet: Tempfile.open('snippet.rb') { |f| f << code },
        spec: Tempfile.open('spec.rb') { |f| f << output },
        gems: gems
    )
    c.create_docker_container
    # c.prepare
    out = c.run

    render json: {output: out}

  end
end
