$('.application_dashboard_metrics').ready(function() {
		console.log("Inside .application_dashboard_metrics");

				$('#captureTimeDatePicker').flatpickr({
								"enableTime": true,
								"enableSeconds": true,
				});
        
				$("#showFullTable").click(function() {
								console.log("showFullTable");
                $(".table .toggleDisplay").toggleClass("in");
        });

});
