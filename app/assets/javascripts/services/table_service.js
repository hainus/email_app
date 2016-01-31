email_app.factory("TableService", function($http) {
  return {
    getTableParams: function(baseUrl, options) {
      var params = {count: 10};
      var settings = {
        total: 0,
        getData: function($defer, params) {
          var filter = params.filter();
          var sorting = params.sorting();
          var perPage = params.count();
          var page = params.page();
          var queryParams = {
            page: page,
            perPage: perPage
          };
          queryParams = _.extend(queryParams, options || {});

          if (!_.isEmpty(filter)) {
            queryParams.filter = filter;
          }
          if (!_.isEmpty(sorting)) {
            queryParams.sorting = sorting;
          }

          var url = baseUrl + "?" + $.param(queryParams);
          $http.get(url).success(function(response) {
            params.total(response.total);
            $defer.resolve(response.data);
          });
        },
        counts: []
      };

      return {
        params: params,
        settings: settings
      }
    }
  };
});