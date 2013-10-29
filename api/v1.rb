Dir[File.expand_path('../resources/**/*.rb', __FILE__)].each {|path| require path}

module PadnGrape
  module API

    class V1 < Grape::API
      prefix 'padngrape'
      format :json
      version 'v1', :using => :path, :vendor => 'padngrape', :format => :json

      before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'
      end

      rescue_from :all do |error|
        if error.class.name.end_with?("AuthenticationError")
          headers =  {
            'Content-type' => 'application/json',
            'WWW-Authenticate' => 'Basic realm="foo"'
          }
          json = { message: "Unauthorized" }.to_json
          code = 401
        else
          logger.error "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']} -- #{error.class.name} -- #{error.message}"
          logger.info "API << Last error's backtrace:\n#{error.backtrace.join("\n")}"
          ENV['DEBUG'] && puts("API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']} -- #{error.class.name} -- #{error.message} -- #{error.backtrace}")

          json = { error: error.class.name.split('::').last, message: "#{error.message}#{Padrino.env.eql?(:test) ? error.backtrace : ""}"}.to_json
          code = error.class.name.to_s.match(/[Vv]alidation/) ? 400 : 500

          headers =
          {
            'Content-Type' => 'application/json',
            'Access-Control-Allow-Origin' => '*',
            'Access-Control-Request-Method' => '*'
          }
        end
        rack_response(json, code, headers)
      end

      desc "For testing API connection"
      get :hello do
        {:message => "Hello, sailor!" }
      end

      mount TestResource
    end
  end
end
