// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
//import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import 'bootstrap'
import '../bootstrap/bootstrap'
import "@fortawesome/fontawesome-free/css/all"


var jQueryBridget = require('packs/jquery-bridget');
var Isotope = require('packs/isotope.pkgd.min');
jQueryBridget( 'isotope', Isotope, $ );


const InfiniteScroll = require('infinite-scroll');
const imagesLoaded = require('imagesloaded');
jQueryBridget( 'infiniteScroll', InfiniteScroll, $ );
InfiniteScroll.imagesLoaded = imagesLoaded;


Rails.start()
//Turbolinks.start()
ActiveStorage.start()


require('jquery')

require('packs/noty/jquery.noty')
require('packs/noty/themes/default')
require('packs/noty/layouts/topRight')
require('packs/fancybox/jquery.fancybox.min')


require('packs/global')