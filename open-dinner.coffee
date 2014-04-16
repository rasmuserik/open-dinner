Dinners = new Meteor.Collection "Dinners"

Router.configure
  layoutTemplate: "layout"
Router.map ->
  this.route "home",
    path: "/"
  this.route "profile"
  this.route "dinner"

sampleDinners = [ {
      _id: "foo"
      date: "Thu Apr&nbsp;14"
      time: "18:00"
      where: "Kbh.NV"
      role: "host"
      tags: ["vegetarian"]
      menu: "Tortilla"
      hosts: ["reblah"]
      capacity: 12
      participants: ["fejnjnjfeabj", "njnjnjn"]
    },{
      _id: "foo"
      date: "Mon Apr&nbsp;28"
      time: "17:00"
      where: "København Nordvest"
      role: "guest"
      tags: ["vegetarian", "vegan-friendly"]
      menu: "veganske pandekager med grøntsagsfyld"
      hosts: ["reblah"]
      capacity: 12
      participants: ["fejnjnjfeabj", "njnjnjn"]
    } ]
if Meteor.isClient #{{{1
  Template.home.upcoming = -> sampleDinners
  Template.dinner.dinner = ->
    date: "Thu Apr&nbsp;14"
    time: "18:00"
    where: "Kbh.NV"
    hosts: ["reblah"]
    tags: ["vegetarian"]
    menu: "Tortilla"
    capacity: 12
    participants: ["fejnjnjfeabj", "njnjnjn"]

  Template.profile.isMe = -> false
  Template.profile.dinnerCreditClass = -> "green" # "red"
  Template.profile.upcomingDinners = -> sampleDinners
  Template.profile.pastDinners = -> sampleDinners
  Template.profile.wall = -> [
      {
        text: "thanks for a wonderful dinner"
        date: "Sat Apr 9"
        from:
          id: "foblah"
          name: "Hello"
      },
      {
        text: "bhbhbhb"
        date: "Mon Apr 2"
        from:
          id: "reblah"
          name: "RasmusErik"
      }
    ]
  Template.profile.profile = ->
      _id: "reblah"
      name: "RasmusErik"
      fullname: "Rasmus Erik Voel Jensen"
      identity: "https://github.com/rasmuserik"
      identityVisible: true
      dinnerCredits: -3
      website: "http://rasmuserik.net"
      contactInfo: "some@example.com\n+45 12345678"
      contactInfoVisible: true
      diningPreferences: "mostly vegetarian"
      upcomingVisible: true
      location:
        address: "Someway 12\n4567 Somewhere"
        geocoordinates: [55.6759400, 12.5655300]
        capacity: 12
        noPets: false
        noSmoking: false


        


if Meteor.isServer #{{{1
  Meteor.startup ->
    undefined
