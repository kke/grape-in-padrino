# Reproducing a problem with grape and padrino

Problem description:
--------------------

1: 

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

2:

Uncomment the following line in api/resources/test_resource.rb   :

    # mount TestResourceChild

Expected behavior (working in earlier version of grape + padrino)

This should work:

    GET /api/padngrape/v1/test/123-test-id/children

And the route should look like:

      (:APIv1)      GET    /api/padngrape/:version/test/:test_id/children(.:format)

But instead we get:

      DEVEL - 25/Oct/2013 20:27:19 Cyclic dependency reload for NameError: uninitialized constant Class::Namespace
        ERROR - 25/Oct/2013 20:27:19 NameError: uninitialized constant Class::Namespace; /usr/local/rvm/gems/ruby-2.0.0-p247@padgrap/bundler/gems/grape-34e6013b4e6f/lib/grape/api.rb:405:in `block in namespace'
        rake aborted!
        uninitialized constant Class::Namespace
