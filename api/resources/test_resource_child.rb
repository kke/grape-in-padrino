module PadnGrape
  module API
    class TestResourceChild < Grape::API
      resource :children do
        get do
          status 200
          {hello: "this is the child for #{params[:test_id]}"}
        end
      end
    end
  end
end

