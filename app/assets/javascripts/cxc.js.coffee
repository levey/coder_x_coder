jQuery ($) ->

	$(".comment").hover( ->
	    $(this).find(".mention_button").show()
	)
	$(".comment").mouseleave( ->
	    $(this).find(".mention_button").hide()
	)
	
	focus_comment_box = ->
	  $(".input-comment-content").focus()

	$(".mention_button").click ->
	  mention = $(this).data('mention')
	  current_content = $("#comment_content").val()
	  new_content = ''
	  if current_content.length > 0
	    new_content = current_content + mention + ' '
	  else
	    new_content = mention + ' '
	  focus_comment_box().val(new_content)
	

