(function(){var e;e=function(){var e,t,n,r,o,a;if($(".fileupload").fileupload(),$(".js-checkbox-toggler").click(function(){return $(this).prop("checked")?$(".js-checkbox-togglee").prop("checked",!0):$(".js-checkbox-togglee").prop("checked",!1)}),$(".js-checkbox-togglee").change(function(){if(!$(this).prop("checked"))return $(".js-checkbox-toggler").prop("checked",!1)}),$(".js-open-modal").click(function(){return $($(this).data("target")).modal()}),$("[data-track-visit=property]").click(function(){var e;return e=$(this).data("property-id"),$.post("/lp/"+e+"/increase_shares_count.json")}),a=function(e){return function(t,n){var r,o;return r=[],o=new RegExp(t,"i"),$.each(e,function(e,t){if(o.test(t))return r.push(t)}),n(r)}},o=["Traffic to your website","Traffic to your property listing","Traffic to your agent profile","Traffic to a HouseQ Landing Page","Engagement on your post","Video views","Reach more people","People to remember my ad","Not sure - help!"],$("#new_facebook_ad .js-typeahead").typeahead({hint:!0,highlight:!0,minLength:0},{name:"states",source:a(o),limit:100}),$(".js-choose-account input[type=checkbox]").change(function(){var e;if($(".js-show-preview").hide(),$(".js-choose-account input:checked").each(function(){var e;return e=$(this).data("network"),$(".js-show-preview[data-network="+e).show()}),e=$(this).data("network"),!0===this.checked)return $(".js-reflect-"+e+"-name").text($(this).data("name")),$(this).data("image").length>0&&$(".js-reflect-"+e+"-image").attr("src",$(this).data("image")),$(".js-reflect-"+e+"-handle").text($(this).data("handle"))}),$("#menu-toggle").click(function(e){return e.preventDefault(),$("#wrapper").toggleClass("toggled")}),$(".js-shorten-url").click(function(e){return e.preventDefault(),$(this).prop("disabled",!0),$(this).text("Shortening..."),$.post("/posts/shorten.js",{url:$("#post_post_url").val()||$("#queue_post_post_url").val()},function(e){return function(t){return $(e).prop("disabled",!1),$(e).text("Shorten"),$("#post_post_url, #queue_post_post_url").val(t)}}(this))}),$(document).on("change",".js-quick-preview-fileupload",function(){var e;return e=new FileReader,e.readAsDataURL(this.files[0]),e.onload=function(e){return function(t){return $(e).next().prop("src",t.target.result),$(".js-preview-image").html($("<img>").attr("src",t.target.result))}}(this)}),$(".js-toggling-checkbox").change(function(){return $(this).parents("label").toggleClass("acc-checked")}),$(document).on("click",".js-show-preview",function(){var e;return e=function(){return $("#twitter_preview, #facebook_preview, #linkedin_preview, #instagram_preview").hide()},e(),$("#"+$(this).data("network")+"_preview").show()}),$("#post_description").length>0&&$(document).on("input","#post_description",function(){return $(".js-reflect-post-content").text($(this).val())}),$(".js-bricks-container").length>0&&(r=[{columns:4,gutter:0}],e=Bricks({container:".js-bricks-container",packed:"data-packed",sizes:r}),e.pack()),load_accounts(),$("input[name='post[utc_offset]']").length>0&&$("input[name='post[utc_offset]']").val(moment().format("Z")),n=moment(),$(".js-datetimepicker").datetimepicker({minDate:n,sideBySide:!0,format:"YYYY-MM-D hh:mm A"}).on("dp.change",function(){return $("form.new_post button[type='submit'] > span").text("Schedule")}),$(".js-datepicker").datetimepicker({minDate:n,sideBySide:!0,format:"YYYY-MM-D"}),$(".js-activity-start-on").length>0&&$(".js-activity-start-on").datetimepicker({format:"YYYY-MM-D"}).on("dp.change",function(e){var t;return t=e.date.add(1,"months").format("YYYY-MM-DD"),$(".js-activity-end-on").val(t)}),$(".dropdown-toggle").length>0&&$(".dropdown-toggle").dropdown(),$("#calendar").length>0)return n=moment(),t=function(e,t){var n;return n=$("#calendar").data("url"),$.getScript(n+"?format=js&date="+e.format("YYYY-MM-DD"),function(){return $(".dropdown-toggle").dropdown()}),$(".fc-today").removeClass("fc-today"),$(t).addClass("fc-today")},{},$("#calendar").fullCalendar({eventBorderColor:"#CD0100",eventBackgroundColor:"#CD0100",header:{left:"prev,next today",center:"title",right:""},defaultDate:n,aspectRatio:1,editable:!0,droppable:!1,eventLimit:2,dayRender:function(e,t){return console.log("day render",e),console.log("day render",t)},eventRender:function(e){return $(e.html)},eventLimitClick:function(e){return t(e.date,this)},dayClick:function(e){return t(e,this)},eventClick:function(e){return t(e.start,this)},eventDrop:function(e){return cur_date>e.start.format()?(sweet_alert("error","Please drag only future dates."),revertFunc()):(e.className="post_status_color_red",change_post_date(e.id,e.start.format(),e.profile_id))},events:$("#calendar").data("events")})},"undefined"!=typeof Turbolinks?document.addEventListener("turbolinks:load",function(){return e()}):$(function(){return e()})}).call(this);