require File.expand_path('../v1.rb', __FILE__)

module PadnGrape

  module API

    # This stuff mostly from PadrinoEatsGrape
    class App < Grape::API
      class << self

        # Without this, we now get an error about undefined method include? for TrueClass
        def cascade
          []
        end

        def root
          @_root ||= File.expand_path('..', __FILE__)
        end

        def dependencies
          @_dependencies ||= [
            "v1.rb", "resources/*.rb"
          ].map { |file| Dir[File.join(self.root, file)] }.flatten
        end

        def load_paths
          @_load_paths ||= %w(models lib controllers).map { |path| File.join(self.root, path) }
        end

        def require_dependencies
          Padrino.set_load_paths(*load_paths)
        end

        def setup_application!
          return if @_configured
          self.require_dependencies
          Grape::API.logger = Padrino.logger
          @_configured = true
          @_configured
        end

        def app_file; ""; end
        def public_folder; ""; end
      end

      setup_application!

      after { logger.info "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']}; errors: #{env["rack.errors"].inspect}" }

      mount ::PadnGrape::API::V1
    end

  end

end

class Grape::Route
  def name
    "API#{route_version}"
  end

  def request_methods
    Set.new [route_method]
  end

  def original_path
    route_path
  end
end

