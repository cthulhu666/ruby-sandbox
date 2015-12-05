require 'docker'

module Sandbox
  class Container

    attr_reader :gems

    def initialize(snippet:, spec:, gems: [])
      @snippet = snippet
      @spec = spec
      @gems = gems
      [snippet, spec].map(&:path).each { |f| File.chmod(0644, f) }
    end

    def create_docker_container
      Rails.logger.info "snippet_path: #{@snippet.path}"
      Rails.logger.info "spec_path: #{@spec.path}"
      @container = Docker::Container.create(
          "Image" => "rspec-nonroot",
          "Memory" => 16.megabytes,
          "CpuQuota" => 50000,
          "ReadonlyRootfs" => true,
          "Volumes" => {"/app/snippet.rb" => {}, "/app/spec/snippet_spec.rb" => {}},
          "Binds" => ["#{@snippet.path}:/app/snippet.rb", "#{@spec.path}:/app/spec/snippet_spec.rb"],
      )
      @name = @container.json['Name'][1..-1]

      Rails.logger.info "Name: #{@name}"
    end

    #def prepare
    #  gems.each do |gem|
    #    @container.exec(['gem', 'install', gem]) { |stream, chunk| puts "#{stream}: #{chunk}" }
    #  end
    #end

    def run
      out = ''
      @container.tap(&:start).attach do |stream, chunk|
        out << chunk
      end
      out
    ensure
      @container.delete(force: true)
    end

  end
end
