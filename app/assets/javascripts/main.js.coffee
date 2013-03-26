window.setAjaxModal = ->
  $("[data-toggle=\"modal\"]").click (e) ->
      e.preventDefault()
      url = $(this).attr("href")
      if url.indexOf("#") is 0
        $(url).modal "open"
      else
        $.get(url, (data) ->
          $("#edit-task-modal").html(data)
          $("#edit-task-modal").modal()
        ).success ->
          $("input:text:visible:first").focus()
$ ->
  setInterval (->
    $.ajax
      url: "/"
      dataType: "script"
    ), 3000
