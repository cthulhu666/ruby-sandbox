class SnippetsController < ApplicationController
  def create
    snippet = Snippet.create!(snippet_params)

    renderer = ERB.new(File.read('lib/templates/spec.rb.erb'))
    output = renderer.result(snippet.instance_eval { binding })

    c = Sandbox::Container.new(
        snippet: Tempfile.open('snippet.rb') { |f| f << snippet.code },
        spec: Tempfile.open('spec.rb') { |f| f << output },
    )

    c.create_docker_container
    # c.prepare
    out = c.run

    render json: {output: out}

  end

  def snippet_params
    params.require(:snippet).permit(:code, :spec)
  end
end
