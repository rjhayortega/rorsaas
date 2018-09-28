var PageTrack = function()
{
    function qs(s){ return document.querySelector(s); }
    function qsa(s){ return document.querySelectorAll(s); }
    function addEvent(el,ev,fn){ el.addEventListener(ev,fn); }
    function domReady(fn){ addEvent(document, 'DOMContentLoaded', fn); }

    var browser = function(){
        var b = bowser;
        return {
            name: b.name,
            device: b.mobile ? 'mobile' : b.tablet ? 'tablet' : 'desktop'
        };
    }();


    // we need to throttle or debounce function calls to events,
    // so we dont get too much or unintended hits.
    function debounce(func, wait, immediate, context)
    {
    	var timeout;
    	return function(){
            var args = arguments;
            context = context||this;
    		var later = function() {
    			timeout = null;
    			if (!immediate) func.apply(context, args);
    		};
    		var callNow = immediate && !timeout;
    		clearTimeout(timeout);
    		timeout = setTimeout(later, wait);
    		if(callNow) func.apply(context, args);
    	};
    }


    domReady(function()
    {
        // EventTypeNo.1: Scroll - 20% of page
        trackScroll(1, 20);

        // EventTypeNo.2: Scroll - 50% plus on page
        trackScroll(2, 50);

        trackClick('[data-pt-event-type]');

    });


    function trackClick(list)
    {
        var a = qsa(list);

        var fn = function(){
            var type = this.getAttribute('data-pt-event-type');
            if(type){
                logEvent(type, {
                    desc: this.getAttribute('data-pt-event-desc')
                });
            }
        }

        for(i=0, t=a.length; i<t; i++)
        {
            addEvent(a[i], 'click', debounce(fn, 1000, true));
        }
    }


    function trackScroll(type, targetPercent)
    {
        var hasReset = true;

        function getPercentScrolled(){
            var D = document;
            var winheight= window.innerHeight || (D.documentElement || D.body).clientHeight;
            var docheight = Math.max(D.body.scrollHeight, D.documentElement.scrollHeight, D.body.offsetHeight, D.documentElement.offsetHeight, D.body.clientHeight, D.documentElement.clientHeight);
            var scrollTop = window.pageYOffset || (D.documentElement || D.body.parentNode || D.body).scrollTop;
            var trackLength = docheight - winheight;
            var pctScrolled = Math.floor(scrollTop/trackLength * 100) // gets percentage scrolled (ie: 80 or NaN if tracklength == 0)
            return pctScrolled;
        }

        var fn = function(){
            // log only if we scrolled pass the target-percent once.
            // scrolling lower than target-percent will reset and log again.
            if(getPercentScrolled() >= targetPercent){
                if(hasReset){
                    hasReset = false;
                    logEvent(type);
                }
            }
            else{
                hasReset = true;
            }
        }

        addEvent(window, 'scroll', debounce(fn, 1000));
    }

    function logEvent(typeNo, data)
    {
        data = data||{};
        data = {
            EventTypeNo: typeNo,
            Description: data.desc,
            Name: data.name,
            Phone: data.phone,
            Email: data.email,
            Device: browser.device,
            Browser: browser.name,
            Url: window.location.href, //current url
            Referrer: document.referrer
        };

        try {
			$.ajax({
				type: "POST",
				url: PageData.savePageEventUrl, // defined in Property.cshtml bottom script section
				data: data,
				success: successCallback,
				error: failureCallback
			});
		}
		catch (e) {
			// console.log('Page Event: Ajax Error');
			// console.log(e);
		}
    }

    function successCallback(result,status,xhr)
	{
		if(result.error){
			// console.log('Page Event: Server Error - ' + result.error);
		}
		else{
            // console.log('woohoo!');
            // console.log(result);
		}
	}

    function failureCallback(xhr,status,error){
		// console.log(status+': '+error);
		// console.log(xhr);
	}

    // return public functions etc.
    return{
        log: debounce(logEvent, 1000, true)
    };



}();


// This is a YouTube API global function
// will be called when script is loaded <script src="https://www.youtube.com/iframe_api"></script>
// https://developers.google.com/youtube/iframe_api_reference
function onYouTubeIframeAPIReady()
{
    player = new YT.Player('videoFrame', {
        events: {
          'onStateChange': onPlayerStateChange
        }
    });

    function onPlayerStateChange(ev)
    {
        var playerStatus = ev.data;

        //playing
        if(playerStatus===1)
        {
            PageTrack.log(10);
        }
    }
}
