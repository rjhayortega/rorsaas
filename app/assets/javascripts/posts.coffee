initEverything = ->
  $(".fileupload").fileupload()
  $(".js-checkbox-toggler").click ->
    if $(this).prop('checked')
      $(".js-checkbox-togglee").prop('checked', true)
    else
      $(".js-checkbox-togglee").prop('checked', false)

  $(".js-checkbox-togglee").change ->
    unless $(this).prop('checked')
      $(".js-checkbox-toggler").prop('checked', false)

  $(".js-open-modal").click ->
    $($(this).data("target")).modal()

  $("[data-track-visit=property]").click ->
    pid = $(this).data("property-id")
    $.post "/lp/#{pid}/increase_shares_count.json"

  substringMatcher = (strs) ->
    return (q, cb) ->
      matches = []
      substrRegex = new RegExp(q, 'i')

      $.each strs, (i, str) ->
        if substrRegex.test(str)
          matches.push(str)

      cb(matches)

  states = ["Traffic to your website","Traffic to your property listing","Traffic to your agent profile","Traffic to a HouseQ Landing Page","Engagement on your post","Video views","Reach more people","People to remember my ad","Not sure - help!"]

  $('#new_facebook_ad .js-typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 0,
  }, {
    name: 'states',
    source: substringMatcher(states),
    limit: 100,
  })

  $(".js-choose-account input[type=checkbox]").change ->
    $(".js-show-preview").hide()
    $(".js-choose-account input:checked").each (input) ->
      network = $(this).data("network")
      $(".js-show-preview[data-network=#{network}").show()

    network = $(this).data('network')
    if this.checked == true
      $(".js-reflect-#{network}-name").text $(this).data('name')

      # We have default image in place if you don't have
      if $(this).data('image').length > 0
        $(".js-reflect-#{network}-image").attr 'src', $(this).data('image')
      $(".js-reflect-#{network}-handle").text $(this).data('handle')

  $(".js-choose-account input[type=checkbox]").change ->
    $(".js-show-preview2").hide()
    $(".js-choose-account input:checked").each (input) ->
      network = $(this).data("network")
      $(".js-show-preview2[data-network=#{network}").show()

    network = $(this).data('network')
    if this.checked == true
      $(".js-reflect-#{network}-name").text $(this).data('name')

      # We have default image in place if you don't have
      if $(this).data('image').length > 0
        $(".js-reflect-#{network}-image").attr 'src', $(this).data('image')
      $(".js-reflect-#{network}-handle").text $(this).data('handle')


  $(document).on "click", ".js-show-preview2", ->
    hideAllPreviews = -> $("#twitter_preview, #facebook_preview, #linkedin_preview, #instagram_preview").hide()

    hideAllPreviews()
    $('#' + $(this).data("network") + '_preview').show()

  $("#menu-toggle").click((e) ->
    e.preventDefault()
    $("#wrapper").toggleClass("toggled")
  )

  $(".js-shorten-url").click (e) ->
    e.preventDefault()
    $(this).prop('disabled', true)
    $(this).text('Shortening...')
    $.post '/posts/shorten.js', url: $("#post_post_url").val() || $("#queue_post_post_url").val(), (data) =>
      $(this).prop('disabled', false)
      $(this).text('Shorten')
      $("#post_post_url, #queue_post_post_url").val(data)

  $('.js-preview-post').click (e) ->
    e.preventDefault();
    previewImgFile = $('.js-quick-preview-fileupload')[0].files[0]
    if (isUrlValid($("#post_post_url").val()) || isUrlValid($('#queue_post_post_url').val())) # && (previewImgFile == '' || typeof previewImgFile == 'undefined')
      $(this).prop('disabled', true)
      $(this).text('Waiting...')
      $.post '/posts/preview.json',  url: $("#post_post_url").val() || $('#queue_post_post_url').val(), dataType: 'json', (data) =>
        $(this).prop('disabled', false)
        $(this).text('Show in preview')
        foo = $.parseJSON(data)
        $('.js-preview-image').html($('<img>').attr('src', foo.image))
        $('.fb--scrape--content').css('display', 'inline-block');
        $('.fb--scrape--content').html('<a class="preview_title" href="' + foo.url + '">' + foo.title + '</a>')
        # $('<span class="preview_title">' + foo.title + '</span>').insertAfter('.js-preview-image')
        $('<a class="preview_text" href="' + foo.url + '">' + foo.content + '</a>').insertAfter('.preview_title')
        $('<a class="preview_url" href="' + foo.url + '">' + foo.url + '</a>').insertAfter('.preview_text')
    else
      if (previewImgFile != '' && typeof previewImgFile != 'undefined')
        oFReader = new FileReader()
        oFReader.readAsDataURL($('.js-quick-preview-fileupload')[0].files[0])
        oFReader.onload = (oFREvent) =>
          $(this).next().prop('src', oFREvent.target.result)
          $(".js-preview-image").html($("<img>").attr("src", oFREvent.target.result))
      

  $(document).on "change", ".js-quick-preview-fileupload", ->
    oFReader = new FileReader()
    oFReader.readAsDataURL(this.files[0])
    oFReader.onload = (oFREvent) =>
      $(this).next().prop('src', oFREvent.target.result)
      $(".js-preview-image").html($("<img>").attr("src", oFREvent.target.result))
      $(this).siblings('a.delete_image').removeClass('hide')

  $(document).on "click", "a.delete_image", ->
    $(this).siblings('input[type="file"]').remove();

    imageElem = $(this).data('elem')
    pageID = $(this).data('page')
    if imageElem == 'image'
      $(this).parent().prepend('<input class="js-quick-preview-fileupload js-post-main-image" accept="image/*" type="file" name="' + pageID + '[image]" id="' + pageID + '_image">')
    else
      $(this).parent().prepend('<input class="js-quick-preview-fileupload" accept="image/*" type="file" name="' + pageID + '[' + imageElem + ']" id="' + pageID + '_' + imageElem + '">')

    $(this).siblings('img').prop('src', "/assets/image_ph.png")
    $(".js-preview-image").html("")
    $(this).addClass('hide')

  $('.js-toggling-checkbox').change ->
    $(this).parents("label").toggleClass("acc-checked")

  $(document).on "click", ".js-show-preview", ->
    hideAllPreviews = -> $("#twitter_preview, #facebook_preview, #linkedin_preview, #instagram_preview").hide()

    hideAllPreviews()
    $('#' + $(this).data("network") + '_preview').show()

  if $("#post_description").length > 0
    $(document).on "input", "#post_description", ->
      $('.js-reflect-post-content').text $(this).val()

  if $("#post_post_url").length > 0
    $(document).on "input", "#post_post_url", ->
      $('.js-reflect-post-url').text $(this).val()

  if $("#queue_post_post_url").length > 0
    $(document).on "input", "#queue_post_post_url", ->
      $('.js-reflect-queue-post-url').text $(this).val()

  if $("#queue_post_description").length > 0
    $(document).on "input", "#queue_post_description", ->
      $('.js-reflect-queue-post-content').text $(this).val()

  if $(".js-bricks-container").length > 0
    sizes = [
      { columns: 4, gutter: 0 },
    ]

    bricks = Bricks({
      container: ".js-bricks-container",
      packed: 'data-packed',
      sizes: sizes
    })

    bricks.pack()

  load_accounts()

  if $("input[name='post[utc_offset]']").length > 0
    $("input[name='post[utc_offset]']").val(moment().format("Z"))
    # $("input[name='post[utc_offset_minute]']").val(moment().utcOffset())

  now = moment()

  $(".js-datetimepicker").datetimepicker(
    minDate: now
    sideBySide: true
    format: "YYYY-MM-D hh:mm A"
  ).on("dp.change", ->
    $("form.new_post button[type='submit'] > span").text "Schedule"
  )

  $(".js-datepicker").datetimepicker(
    minDate: now
    sideBySide: true
    format: "YYYY-MM-D"
  )

  if $('.js-activity-date').length > 0
    $('.js-activity-date').datetimepicker(
      format: "YYYY-MM-D"
    )

  if $('.dropdown-toggle').length > 0
    $('.dropdown-toggle').dropdown()

  if $("#calendar").length > 0
    now = moment()

    loadCalendar = (moment, target) ->
      path = $("#calendar").data("url")
      $.getScript(path + "?format=js&date=" + moment.format("YYYY-MM-DD"), ->
        $('.dropdown-toggle').dropdown()
      )
      $(".fc-today").removeClass("fc-today")
      $(target).addClass("fc-today")

    displayed = {}

    $('#calendar').fullCalendar(
      eventBorderColor: '#CD0100',
      eventBackgroundColor: '#CD0100',
      header:
        left: 'prev,next today',
        center: 'title',
        right: ''
      defaultDate: now,
      aspectRatio: 1,
      editable: true,
      droppable: false,
      eventLimit: 2,

      dayRender: (date, cell) ->
        ###console.log('day render', date)
        console.log('day render', cell)
  ###
      eventRender: (event, element, view) ->
        $(event.html)

      eventLimitClick: (cellInfo, jsEvent) -> loadCalendar(cellInfo.date, this)
      dayClick: (date, jsEvent, view) -> loadCalendar(date, this)
      eventClick: (calEvent, jsEvent, view) ->
        loadCalendar(calEvent.start, this)

      eventDrop: (calEvent, jsEvent, view) ->
        if cur_date > calEvent.start.format()
          sweet_alert('error', 'Please drag only future dates.')
          revertFunc()
        else
          calEvent.className = "post_status_color_red"
          change_post_date(calEvent.id, calEvent.start.format(), calEvent.profile_id)

      events: $("#calendar").data("events")
    )

if typeof Turbolinks != 'undefined'
  document.addEventListener "turbolinks:load", ->
    initEverything()
else
  $ ->
    initEverything()
