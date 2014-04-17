#{{{1 dummy data
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
      _id: "bar"
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
#{{{1 setup database
Dinners = new Meteor.Collection "Dinners"
UserInfo = new Meteor.Collection "UserInfo"

#{{{1 Router
Router.configure
  layoutTemplate: "layout"
Router.map ->
  this.route "home",
    path: "/"
  this.route "setup"
  this.route "profile",
    path: "/profile/:id?"
    data: ->
      id = this.params._id || Meteor.userId()
      user = Meteor.users.findOne {_id: id}
      return {} if !user
      profile = user.profile
      return {
        isMe: Meteor.userId() == id
        dinnerCreditClass: if user.profile.dinnerBalance < 0 then "red" else "green"
        upcomingDinners: sampleDinners
        pastDinners: sampleDinners
        profile: user.profile
      }
  this.route "dinner",
    path: "/dinner/:id?"
    data: -> {}


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

  #{{{2 profile
  Template.profile.rendered = ->
    loadMap = ->
      if document.getElementById "map"
        loc = [55.6759400, 12.5655300]
        map = L.map('map').setView(loc, 14)
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map)
        L.marker(loc).addTo(map)
    setTimeout loadMap, 1000

  Template.profile.events
    "change .input": (event) ->
      $elem = $(event.target)
      name = $elem.data().name
      if "checkbox" == $elem.attr "type"
        value = if $elem.prop("checked") then true else false
      else
        value = $elem.val()
      change = {$set: {}}
      change.$set["profile.#{name}"] = value
      console.log JSON.stringify change
      Meteor.users.update {_id: Meteor.userId()}, change

  Deps.autorun ->
    user = Meteor.user()
    return if ! user
    profile = user.profile
    if "number" != typeof profile.dinnerCredits
      profile.nickname = profile.name
      profile.identityVisible = true
      profile.dinnerCredits = 0
      profile.contactInfo = ""
      profile.upcomingVisible = true
      profile.diningPreferences = ""
      profile.location =
        address: "Someway 123\n4567 Somewhere"
        geocoordinates: [55.6759400, 12.5655300]
        capacity: 0
        noPets: false
        noSmoking: false
      if user.services.github
        profile.identity = "https://github.com/#{user.services.github.username}"
      else
        alert "unknown service #{Object.keys user.services}"
      Meteor.users.update {_id: user._id}, {$set: {profile: profile}}

if Meteor.isServer #{{{1
  Meteor.startup ->
    undefined
