Router.route('/', {
  name: 'home'
});

Router.route('/dashboard', {
  name: 'dashboard',
  controller: 'DashboardController'
});

Router.route('/voucherNew', {
  name: 'voucherNew',
  controller: 'voucherNewController'
});

Router.route('/voucherEdit/:code', {
  name: 'voucherEdit',
  controller: 'voucherEditController'
});

Router.plugin('ensureSignedIn', {
  only: ['dashboard']
});
