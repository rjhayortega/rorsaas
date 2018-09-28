(function ($) {

    var client_id = '296787575844-4drm5spmgap7aicnumq3k7b0i45a7e0b.apps.googleusercontent.com';
    var scopes = ["https://www.googleapis.com/auth/calendar"];
    var startDate;
    var endDate;
    var mapAddress;
    var timeZone;

    function authorizeUser() {
        $('#add-to-calendar').on('click', function (e) {
            gapi.auth.authorize(
                { client_id: client_id, scope: scopes, immediate: false, authuser: '' },
                handleAuthResult);

            startDate = $(this).attr('data-event-start-date');
            endDate = $(this).attr('data-event-end-date');
            mapAddress = $(this).attr('data-event-address');
            timeZone = $(this).attr('data-event-timeZone');
        });
    }

    function openIframe() {
        var src = $('#upwDomain').val() + '/calendarPopup?' + 'displayAddress=' + $('#iframeCalendarAddress').val()
            + '&mapAddress=' + $('#mapAddress').val() + '&timeZone=' + $('#timeZone').val()
            + '&startDate=' + $(this).attr('data-event-start-date') + '&endDate=' + $(this).attr('data-event-end-date')
            + '&secondaryColour=' + $('#secondaryColour').val().replace('#', '') + '&themeNo=' + $('#themeNo').val();

        $("#calendarModal iframe").attr({
            'src': src
        });
    }

    $(document).ready(function () {
        
        $('.addToCalendar').on('click', openIframe);

        authorizeUser();
    });

    function handleAuthResult(authResult) {
        if (authResult && !authResult.error) {
            gapi.client.load('calendar', 'v3', addCalendarEvent);
        }
    }

    function addCalendarEvent() {
        var resource = {
            "summary": "Open for Inspection - " + mapAddress,
            "location": mapAddress,
            "start": {
                "dateTime": startDate,
                "timeZone": timeZone
            },
            "end": {
                "dateTime": endDate,
                "timeZone": timeZone
            }
        };
        var request = gapi.client.calendar.events.insert({
            'calendarId': 'primary',
            'resource': resource
        });
        request.execute(function (resp) {
            // console.log(resp);
        });
    }
})(jQuery);