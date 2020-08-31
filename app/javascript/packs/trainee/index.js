require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('jquery')
require('bootstrap')

import I18n from 'i18n-js';
global.I18n = I18n;

global.toastr = require('toastr');

$(document).on('turbolinks:load', function() {
  // loadTask();
})
