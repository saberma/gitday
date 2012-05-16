#= require jquery
#= require jquery_ujs
#= require_tree .

#= require twitter/bootstrap/dropdown.js
#= require twitter/bootstrap/tooltip.js
#= require twitter/bootstrap/popover.js


$(document).ready ->
  $('.dropdown-toggle').dropdown()
  $('#main').tooltip selector: "span[rel=tooltip], a[rel=tooltip]"
  $('#main').popover selector: "img[rel=popover]", placement: "top"
