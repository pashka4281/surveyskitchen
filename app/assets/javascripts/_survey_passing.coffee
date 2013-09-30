jQuery.fn.preventDoubleSubmission = ->
  $(this).bind "submit", (e) ->
    _form = $(this)
    if _form.data("submitted") is true
      e.preventDefault()
    else if _form.validationEngine('validate')
      _form.data "submitted", true

  this


$(document).ready ->
  _form = $("#survey_form")
  _form.validationEngine "attach",
    promptPosition: "inline"
    scroll: true

  _form.preventDoubleSubmission()
  $(".signature-pad").each ->
    _this = $(this)
    _this.jSignature()
    _this.bind "change", (e) ->
      _this.next(".output").val _this.jSignature("getData", "base30")


  $(".video-wrapper").fitVids()