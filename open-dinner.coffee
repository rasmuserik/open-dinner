Dinners = new Meteor.Collection "Dinners"

Router.configure
  layoutTemplate: "layout"
Router.map ->
  this.route "home",
    path: "/"
  this.route "profile"
  this.route "dinner"

if Meteor.isClient #{{{1
  Template.home.upcoming = ->
    [ {
      _id: "foo"
      date: "Thu Apr&nbsp;14"
      time: "18:00"
      where: "Kbh.NV"
      tags: ["vegetarian"]
      menu: "Tortilla"
      capacity: 12
      participants: ["fejnjnjfeabj", "njnjnjn"]
    },{
      _id: "foo"
      date: "Mon Apr&nbsp;28"
      time: "17:00"
      where: "København Nordvest"
      tags: ["vegetarian", "vegan-friendly"]
      menu: "veganske pandekager med grøntsagsfyld"
      capacity: 12
      participants: ["fejnjnjfeabj", "njnjnjn"]
    } ]
  Template.dinner.dinner = ->
    date: "Thu Apr&nbsp;14"
    time: "18:00"
    where: "Kbh.NV"
    tags: ["vegetarian"]
    menu: "Tortilla"
    capacity: 12
    participants: ["fejnjnjfeabj", "njnjnjn"]


if Meteor.isServer #{{{1
  Meteor.startup ->
    undefined
