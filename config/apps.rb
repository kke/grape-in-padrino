Padrino.configure_apps do
end

require Padrino.root('api/app.rb')

Padrino.mount('PadnGrape::API::App', :app_file => Padrino.root('api/app.rb')).to('/api')
Padrino.mount('PadnGrape::App', :app_file => Padrino.root('app/app.rb')).to('/')

