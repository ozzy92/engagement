// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// just a test to see if jquery is getting pulled in
//$(document).ready(() => $('body').css('background-color', 'lightblue'));


// the above docs are fairly useless, since I don't know how webpack works
// this doesn't make any sense, but I found this method here....
// https://dev.to/morinoko/adding-custom-javascript-in-rails-6-1ke6
// this doesn't seem like a great way to do things, there must be a better way
import generate_cost_center from "./department_cost_center";
window.generate_cost_center = generate_cost_center
