import "bootstrap";
import "mapbox-gl/dist/mapbox-gl.css"; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import "plugins/flatpickr";

import { initMapbox } from "../plugins/init_mapbox";
import { home } from "../home/home";
import { initSweetalert } from "../plugins/init_sweetalert";
import { dropdownSubmit } from "../plugins/dropsubmit";

window.$ = window.jQuery = require('jquery');

dropdownSubmit();
initAutocomplete();
initMapbox();
