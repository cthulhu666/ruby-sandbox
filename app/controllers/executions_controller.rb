class ExecutionsController < ApplicationController
  def create
    renderer = ERB.new(File.read('lib/templates/spec.rb.erb'))
    output = renderer.result(binding)

    c = Sandbox::Container.new(
      snippet: Tempfile.open('snippet.rb') { |f| f << snippet_params[:code] },
      spec: Tempfile.open('spec.rb') { |f| f << output }
    )

    c.create_docker_container
    # c.prepare

    Timeout.timeout(timeout) do
      out = c.run
      render json: { output: out }
    end
  end

  def snippet_params
    params.require(:snippet).permit(:code, :spec)
  end
  private :snippet_params

  def timeout
    ENV.fetch('EXECUTION_TIMEOUT', 2).to_i.seconds
  end
  private :timeout
end
