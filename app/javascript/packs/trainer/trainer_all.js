require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('jquery')
require('bootstrap')
require('cocoon-js')
require('../../custom')

import I18n from 'i18n-js';
global.I18n = I18n;

global.toastr = require('toastr');

import Swal from 'sweetalert2/dist/sweetalert2.js';
import 'sweetalert2/src/sweetalert2.scss';

window.Swal = Swal;

import {deleteSubject, viewSubjectDetail} from './subject';

$(document).on('turbolinks:load', function() {
  deleteSubject();
  viewSubjectDetail();
})

import $ from 'jquery';
global.$ = $
global.jQuery = $
require('jquery-ui');
require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.css/ );
require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.theme\.css/ );
