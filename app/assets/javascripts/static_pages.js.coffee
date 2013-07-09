# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#micropost_content").bind "input", ->
    post_length = @.value.length
    if post_length <= 140
      message = (140 - post_length) + " characters remaining..."
    else
      message = "Your micropost is too long!"

    $("#count_down").text(message)


