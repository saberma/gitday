#= require jquery
#= require jquery_ujs
#= require jquery.timeago
#= require app

#= require twitter/bootstrap/dropdown.js
#= require twitter/bootstrap/tooltip.js


$(document).ready ->
  $('.dropdown-toggle').dropdown()
  $("span.timeago").timeago()
  $('#main').tooltip selector: "span[rel=tooltip], a[rel=tooltip]"
