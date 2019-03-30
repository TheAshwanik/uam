$('.platform_dashboard_metrics').ready(function() {
		console.log("Inside .platform_dashboard_metrics.index");

				$('#captureTimeDatePicker').flatpickr({
								"enableTime": true,
								"enableSeconds": true,
				});

        $("#showFullTable").click(function() {
                console.log("showFullTable");
                $(".table .toggleDisplay").toggleClass("in");
        });


});
