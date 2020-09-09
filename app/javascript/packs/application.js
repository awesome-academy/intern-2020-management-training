require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('jquery')
require('bootstrap')
require('cocoon-js')

import I18n from 'i18n-js';
import Swal from 'sweetalert2/dist/sweetalert2.js';
import 'sweetalert2/src/sweetalert2.scss';

window.Swal = Swal;

global.I18n = I18n;
global.toastr = require('toastr');
