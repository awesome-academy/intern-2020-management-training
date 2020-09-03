require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('jquery')
require('bootstrap')
require('cocoon-js')

import I18n from 'i18n-js';
import Swal from 'sweetalert2/dist/sweetalert2.js'
import 'sweetalert2/src/sweetalert2.scss'
import $ from 'jquery';

window.Swal = Swal;

global.I18n = I18n;
global.toastr = require('toastr');
global.$ = $
global.jQuery = $
require('jquery-ui');
require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.css/ );
require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.theme\.css/ );
