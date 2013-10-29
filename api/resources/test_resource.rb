module PadnGrape
  module API
    class TestResource < Grape::API
      resource :test do
        get do
          status 200
          {hello: "hello from test resource"}
        end

        route_param :test_id do
          get do
            {hello: "looking at test id #{params[:test_id]} here"}
          end
          # mount PadnGrape::API::TestResourceChild
        end

      end
    end
  end
end
