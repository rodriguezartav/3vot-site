Spine = require("spine")
HeaderLink = require("headerLink")
require("lib/setup")

class App extends Spine.Controller

  constructor: ->
    super 

    LazyLoad.js "/devBuild/contentBox.js", ->
      require("lib/setup")
      ContentBox = require("components/contentBox/contentBox")
      new ContentBox( el: $("aside") , tagSelectors: "h2,h3" , sourceSelector: "article")
      #new HeaderLink window.location.pathname, $(".header a")
  
module.exports = App    