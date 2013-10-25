module PadnGrape
  class App < Padrino::Application

    get :index, :map => '/' do
      "Hello!"
    end

  end
end
