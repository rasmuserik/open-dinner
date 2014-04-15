Dinners = new Meteor.Collection "Dinners"

Router.configure
  layoutTemplate: "layout"
Router.map ->
  this.route "home",
    path: "/"
  this.route "host"
  this.route "dine"

if Meteor.isClient #{{{1
  Template.host.rendered = ->
    $('.datetimepicker').datetimepicker
      format: "YYYY-MM-DD HH:mm"
      weekStart: 1
  Template.home.greeting = -> "welcome to here"
  Template.home.events
    "click input": ->
      alert "click"

if Meteor.isServer #{{{1
  Meteor.startup ->
    undefined
