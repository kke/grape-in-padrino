Grape running under Padrino
---------------------------

Began as an issue reproduction for Grape, which is now resolved.

Leaving this repository here for anyone interested.

Partly borrowed from PadrinoEatsGrape at https://github.com/eivan/PadrinoEatsGrape

This has an example of nested mounts, such as:

    # parent_resource.rb
    resource :parent do
      get do
        # list parents
      end

      route_param :parent_id do
        get do
          # show parent
        end

        mount Children
      end
    end

    # children_resource.rb
    resource :children do
      get do
        # list children
        # for params[:parent_id]
      end
    end

    # Which results to a route like:
    # /api/:version/parent/:parent_id/children
