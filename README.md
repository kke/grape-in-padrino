Reproducing a problem
---------------------

# Problem 1

Routes are doubled, each grape route appears twice.

    $ rake routes
    Application: PadnGrape::API::App
      URL         REQUEST  PATH
      (:APIv1)      GET    /api/padngrape/:version/hello(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id(.:format)

    Application: PadnGrape::App
      URL               REQUEST  PATH
      (:index)            GET    /
      (:test, :test)      GET    /test 

Modifying the Gemfile by switching to old padrino and old grape removes
this doubling problem:

    ruby-2.0.0-p247@padgrap [master*] /opt/reproduce-grape-problem $ bundle show padrino
    /usr/local/rvm/gems/ruby-2.0.0-p247@padgrap/gems/padrino-0.11.4
    ruby-2.0.0-p247@padgrap [master*] /opt/reproduce-grape-problem $ bundle show grape
    /usr/local/rvm/gems/ruby-2.0.0-p247@padgrap/bundler/gems/grape-6e418d303463
    ruby-2.0.0-p247@padgrap [master*] /opt/reproduce-grape-problem $ rake routes

    Application: PadnGrape::API::App
        URL         REQUEST  PATH
        (:APIv1)      GET    /api/padngrape/:version/hello(.:format)
        (:APIv1)      GET    /api/padngrape/:version/test(.:format)
        (:APIv1)      GET    /api/padngrape/:version/test/:test_id(.:format)
    
    Application: PadnGrape::App
        URL               REQUEST  PATH
        (:index)            GET    /
        (:test, :test)      GET    /test
    

# Problem 2

Uncomment the following line in api/resources/test_resource.rb   :

    # mount TestResourceChild

And the route should look like:

      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/children(.:format)

And this should work:

    GET /api/padngrape/v1/test/123-test-id/children

But instead we get:

    Application: PadnGrape::API::App
      URL         REQUEST  PATH
      (:APIv1)      GET    /api/padngrape/:version/hello(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/test(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/test/:test_id(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/test/:test_id/test/:test_id/children(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/test(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/test/:test_id(.:format)
      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/test/:test_id/test/:test_id/children(.:format)
