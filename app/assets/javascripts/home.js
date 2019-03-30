$('.home.index').ready(function() {
 				console.log(".home.index");
				refreshServiceState();
				refreshAppMetrics();
				refreshPlatformMetrics();

				function logConsoleMessage(msg) {
					console.log(new Date().toTimeString() + ": " + msg);
				}
				var awayCallback = function() {
					logConsoleMessage("away");
					refreshAppMetrics();
					refreshPlatformMetrics();
					refreshServiceState();
				};
				var awayBackCallback = function() {
					logConsoleMessage("back");
				};
				var hiddenCallback = function() {
					logConsoleMessage("User is not looking at page");
				};
				var visibleCallback = function(){
					logConsoleMessage("User started looking at page again")
					refreshAppMetrics();
					refreshPlatformMetrics();
					refreshServiceState();
				};
				
				var idle = new Idle({
					onHidden : hiddenCallback,
					onVisible : visibleCallback ,
					onAway : awayCallback,
					onAwayBack : awayBackCallback,
					awayTimeout : $('#Timeout').val() //away with default value of the textbox
				});

				$('#Timeout').keydown(function(e) {
					if(e.keyCode == 13) {
						var timeout = $(this).val();
						logConsoleMessage("Timeout changed to: " + timeout);
						idle.setAwayTimeout(timeout);
					}
				})
	
		 var time = new Date().getTime();
     $(document.body).bind("mousemove keypress", function(e) {
         time = new Date().getTime();
     });

     function refresh() {
         if(new Date().getTime() - time >= $('#Timeout').val()){ 
             //window.location.reload(true);
							logConsoleMessage("Timeout expired - Calling refreshAppMetrics");
						 refreshAppMetrics();
					   refreshPlatformMetrics();
					   refreshServiceState();
					}
         else{ 
						 logConsoleMessage("Timeout not expired ");
             setTimeout(refresh, 5000);
				 }
     }

     setTimeout(refresh, 10000);


	 //setInterval(refreshAppMetrics, 5000);

 //logConsoleMessage("----Page Load----");
	var servicepanels=localStorage.servicepanels === undefined ? new Array() : JSON.parse(localStorage.servicepanels); //get all panels
    for (var i in servicepanels)
		{ //<-- panel is the name of the cookie
        if ($("#"+servicepanels[i]).hasClass('servicetarget collapse')) // check if this is a panel
        {
						logConsoleMessage("Open panel found - Opening " + "#"+servicepanels[i]);
            $("#"+servicepanels[i]).collapse("show");
						$("#"+servicepanels[i]).closest(".servicecols").removeClass('col');
						$("#"+servicepanels[i]).closest(".servicecols").addClass('col-12');
						
						//$("#"+servicepanels[i]).find('#metric_'+servicepanels[i]).load("/application_dashboard_metrics/service_status", { serviceid: $("#"+servicepanels[i]).attr('data-serviceid') });
        }
  	}  
	

	var apppanels=localStorage.apppanels === undefined ? new Array() : JSON.parse(localStorage.apppanels); //get all panels
    for (var i in apppanels)
		{ //<-- panel is the name of the cookie
        if ($("#"+apppanels[i]).hasClass('apptarget collapse')) // check if this is a panel
        {
						logConsoleMessage("Open panel found - Opening " + "#"+apppanels[i]);
            $("#"+apppanels[i]).collapse("show");
						$("#"+apppanels[i]).closest(".appcols").removeClass('col');
						$("#"+apppanels[i]).closest(".appcols").addClass('col-12');

						//logConsoleMessage($("#"+apppanels[i]).attr('data-appid'));
						//$("#"+apppanels[i]).find('#metric_'+apppanels[i]).load("/application_dashboard_metrics/metrics_status", { appid: $("#"+apppanels[i]).attr('data-appid') });
        }
		}
	


	$('.servicetarget.collapse').on('shown.bs.collapse', function (e) {
		////logConsoleMessage($(".servicecols"));
		$(".servicecols").removeClass('col-12');
		$(".servicetarget.collapse.show").closest(".servicecols").addClass('col-12');
		$(".servicetarget.collapse.show").closest(".servicecols").removeClass('col');

		var active = $(this).attr('id');
		logConsoleMessage("saving state for "+ active + " element" );

    logConsoleMessage("---------Removing both--------------");
    var servicepanels=localStorage.servicepanels === undefined ? new Array() : JSON.parse(localStorage.servicepanels);
		servicepanels=[]
    var apppanels= localStorage.apppanels === undefined ? new Array() : JSON.parse(localStorage.apppanels);
		apppanels=[]
		logConsoleMessage(localStorage.servicepanels);
		logConsoleMessage(localStorage.apppanels);
    logConsoleMessage("---------Removed both--------------");

		//if ($.inArray(active,servicepanels)==-1) //check that the element is not in the array
        servicepanels.push(active);
    localStorage.servicepanels=JSON.stringify(servicepanels);
    logConsoleMessage("---------Adding--------------");
    logConsoleMessage(localStorage.servicepanels);
    logConsoleMessage("---------Added--------------");

	})
	
	$('.servicetarget.collapse').on('hidden.bs.collapse', function (e) {
		//alert('.servicetarget.collapse hidden');
		var active = $(this).attr('id');
		logConsoleMessage("Hide event triggered for "+ active + " element" );
    var servicepanels= localStorage.servicepanels === undefined ? new Array() : JSON.parse(localStorage.servicepanels);
    var elementIndex=$.inArray(active,servicepanels);
    if (elementIndex!==-1) //check the array
    {
        servicepanels.splice(elementIndex,1); //remove item from array        
				logConsoleMessage("Removing state for "+ active + " element" );
    }
    localStorage.servicepanels=JSON.stringify(servicepanels); //save array on localStorage
	})


	$('.apptarget.collapse').on('shown.bs.collapse', function (e) {
		//logConsoleMessage($(this));
		//alert('.apptarget.collapse');
		//logConsoleMessage($(".appcols"));
		$(".appcols").removeClass('col-12');
		$(".apptarget.collapse.show").closest(".appcols").addClass('col-12');
		$(".apptarget.collapse.show").closest(".appcols").removeClass('col');


		var active = $(this).attr('id');
		logConsoleMessage("saving state for "+ active + " element" );

    logConsoleMessage("---------Removing apppanels-------------");
    var apppanels= localStorage.apppanels === undefined ? new Array() : JSON.parse(localStorage.apppanels);
		apppanels=[]
		logConsoleMessage(localStorage.apppanels);
    logConsoleMessage("---------Removed apppanels-------------");

    //if ($.inArray(active,apppanels)==-1) //check that the element is not in the array
        apppanels.push(active);
    logConsoleMessage("---------Adding apppanels--------------");
    localStorage.apppanels=JSON.stringify(apppanels);
    logConsoleMessage(localStorage.apppanels);
    logConsoleMessage("---------Added apppanels--------------");

		logConsoleMessage($(active).find('#metric_'+active));
		//$("#"+active).find('#metric_'+active).load("/application_dashboard_metrics/metrics_status", { appid: $(this).attr('data-appid') });
	})

	$('.apptarget.collapse').on('hidden.bs.collapse', function (e) {
		var active = $(this).attr('id');
		logConsoleMessage("Hidden event triggered for "+ active + " element" );
    var apppanels= localStorage.apppanels === undefined ? new Array() : JSON.parse(localStorage.apppanels);
    var elementIndex=$.inArray(active,apppanels);
    if (elementIndex!==-1) //check the array
    {
        apppanels.splice(elementIndex,1); //remove item from array        
				logConsoleMessage("Removing state for "+ active + " element" );
    }
    localStorage.apppanels=JSON.stringify(apppanels); //save array on localStorage
	})



  // calls action refreshing the partial
  function refreshAppMetrics() {
			 $.ajax({
                    type: "GET",
                    url: "/application_dashboard_metrics/get_app_metrics",
                    dataType: "json",
                    success: function(data){
                        var service_id = "";
                        var s_status = [];
                        var m_status = [];
                        var a_status = [];
                        var application_id = "";
                        var metric_value = "";
                        var metric_status = "";
                        var metric_description = "";
                        var metric_capture_time = "";
												var ONE_HOUR = 60 * 60 * 1000;
												var CONST_FAIL_STATUS = "KO";
												var CONST_PASS_STATUS = "OK";

                        for (var x = 0; x < data['service_status'].length; x++) {
                            logConsoleMessage(data['service_status'][x]);
														service_id = data['service_status'][x].service_id;
														application_id = data['service_status'][x].application_id;
														metric_name = data['service_status'][x].metric_name;
														metric_value = data['service_status'][x].metric_value;
														metric_status = data['service_status'][x].metric_status;
														metric_capture_time = data['service_status'][x].capture_time;
														metric_description = data['service_status'][x].metric_description;

														logConsoleMessage("refreshAppMetrics---service_id=" + service_id + "--application_id=" + application_id 
															+ "--metric_name=" + metric_name + "--metric_status=" + metric_status + "--metric_value=" + metric_value
															+ "--metric_description=" + metric_description + "--metric_capture_time--" + metric_capture_time);

															if(metric_status == CONST_FAIL_STATUS)
															{
																m_status[data['service_status'][x].application_id] = metric_name+":"+metric_status;
															}
															else
															{
																if (m_status[data['service_status'][x].application_id] == (metric_name+":"+CONST_FAIL_STATUS))
																	m_status[data['service_status'][x].application_id] = metric_name+":"+metric_status;
															}

               					} //end of for
												
												for (var metrickey in m_status) {
																logConsoleMessage("refreshAppMetrics---metrickey " + metrickey + " has value " + m_status[metrickey]);

																if(getSecondPart(m_status[metrickey]) == CONST_FAIL_STATUS){
																	$("#app_metrics_"+ metrickey).removeClass("btn-success");
																	$("#app_metrics_"+ metrickey).addClass("btn-danger");
																}
																else{
																	$("#app_metrics_"+ metrickey).removeClass("btn-danger");
																	$("#app_metrics_"+ metrickey).addClass("btn-success");
																}
												}		
										
		 								}
								});
   }

	function getSecondPart(str) {
    return str.split(':')[1];
	}

	// calls action refreshing the partial
  function refreshPlatformMetrics() {
       $.ajax({
                    type: "GET",
                    url: "/platform_dashboard_metrics/get_platform_metrics",
                    dataType: "json",
                    success: function(data){
                        var service_id = "";
                        var s_status = [];
                        var m_status = [];
                        var a_status = [];
                        var application_id = "";
                        var metric_value = "";
                        var metric_status = "";
                        var metric_description = "";
                        var metric_capture_time = "";
                        var ONE_HOUR = 60 * 60 * 1000;
                        var CONST_FAIL_STATUS = "KO";
                        var CONST_PASS_STATUS = "OK";

                        for (var x = 0; x < data['service_status'].length; x++) {
                            logConsoleMessage(data['service_status'][x]);
                            service_id = data['service_status'][x].service_id;
                            application_id = data['service_status'][x].application_id;
                            metric_name = data['service_status'][x].metric_name;
                            metric_value = data['service_status'][x].metric_value;
                            metric_status = data['service_status'][x].metric_status;
                            metric_capture_time = data['service_status'][x].capture_time;
                            metric_description = data['service_status'][x].metric_description;

                            logConsoleMessage("refreshPlatformMetrics---service_id=" + service_id + "--application_id=" + application_id
                              + "--metric_name=" + metric_name + "--metric_status=" + metric_status + "--metric_value=" + metric_value
                              + "--metric_description=" + metric_description + "--metric_capture_time--" + metric_capture_time);

                            logConsoleMessage("Capture time diff---" + ((new Date) - new Date(metric_capture_time)));
                              if(metric_status == CONST_FAIL_STATUS)
                              {
                                m_status[data['service_status'][x].application_id] = metric_name+":"+metric_status;
                              }
                              else
                              {
                                if (m_status[data['service_status'][x].application_id] == (metric_name+":"+CONST_FAIL_STATUS))
                                  m_status[data['service_status'][x].application_id] = metric_name+":"+metric_status;
                              }

                        } //end of for

                        for (var metrickey in m_status) {
                                logConsoleMessage("refreshPlatformMetrics---metrickey " + metrickey + " has value " + m_status[metrickey]);

                                if(getSecondPart(m_status[metrickey]) == CONST_FAIL_STATUS){
                                  $("#platform_metrics_"+ metrickey).removeClass("btn-success");
                                  $("#platform_metrics_"+ metrickey).addClass("btn-danger");
                                }
                                else{
                                  $("#platform_metrics_"+ metrickey).removeClass("btn-danger");
                                  $("#platform_metrics_"+ metrickey).addClass("btn-success");
                                }
                        }

                    }
                });
   }

// calls action refreshing the partial
function refreshServiceState() {
	$.ajax({
		type: "GET",
		url: "/home/get_services_status",
		dataType: "json",
		success: function(data){
			var service_id = "";
			var s_status = [];
			var m_status = [];
			var a_status = [];
			var application_id = "";
			var metric_value = "";
			var metric_status = "";
			var metric_description = "";
			var metric_capture_time = "";
			var ONE_HOUR = 60 * 60 * 1000;
			var CONST_FAIL_STATUS = "KO";
			var CONST_PASS_STATUS = "OK";

			for (var x = 0; x < data['status']['app_status'].length; x++) {
				application_id = data['status']['app_status'][x].application_id;
				metric_status = data['status']['app_status'][x].metric_status;

				logConsoleMessage("refreshServiceState--application_id=" + application_id
				  + "--metric_status=" + metric_status );

					if(metric_status == CONST_FAIL_STATUS){
					  $("#app_id_"+ application_id).removeClass("border-success");
					  $("#app_id_"+ application_id).addClass("border-danger");
					  $("#app_heading_id_"+ application_id).removeClass("border-success");
					  $("#app_heading_id_"+ application_id).addClass("border-danger");
					}
					else{
					  $("#app_id_"+ application_id).removeClass("border-danger");
					  $("#app_id_"+ application_id).addClass("border-success");
					  $("#app_heading_id_"+ application_id).removeClass("border-danger");
					  $("#app_heading_id_"+ application_id).addClass("border-success");
					}

			} //end of for

			for (var x = 0; x < data['status']['service_status'].length; x++) {
				service_id = data['status']['service_status'][x].service_id;
				metric_status = data['status']['service_status'][x].metric_status;

				logConsoleMessage("refreshServiceState--service_id=" + service_id
				  + "--metric_status=" + metric_status );

					if(metric_status == CONST_FAIL_STATUS){
					  $("#service_id_"+ service_id).removeClass("border-success");
					  $("#service_id_"+ service_id).addClass("border-danger");
					  $("#service_heading_id_"+ service_id).removeClass("border-success");
					  $("#service_heading_id_"+ service_id).addClass("border-danger");
					}
					else{
					  $("#service_id_"+ service_id).removeClass("border-danger");
					  $("#service_id_"+ service_id).addClass("border-success");
					  $("#service_heading_id_"+ service_id).removeClass("border-danger");
					  $("#service_heading_id_"+ service_id).addClass("border-success");
					}

			} //end of for

		}
	});
}

 /*
 var searchTerm, panelContainerId;
  // Create a new contains that is case insensitive
  $.expr[":"].containsCaseInsensitive = function(n, i, m) {
		if(jQuery(n).text().toUpperCase().indexOf(m[3].toUpperCase()) >=0)
		{
			//logConsoleMessage(n);
			//logConsoleMessage ("------------->"+ jQuery(n).text().toUpperCase());
			//logConsoleMessage ("------------->"+ jQuery(n).text().toUpperCase().indexOf(m[3].toUpperCase()));
			jQuery(n).find(".apptarget.collapse").each(function() {
				 	appContainerId = $(this).attr("id");
					//logConsoleMessage("============================>" + appContainerId);

					//$(this).show();
					jQuery(n).find('#metric_'+appContainerId).closest(".appcols").removeClass('col');
					jQuery(n).find('#metric_'+appContainerId).closest(".appcols").addClass('col-12');
					jQuery(n).find('#metric_'+appContainerId).load("/application_dashboard_metrics/metrics_status", { appid: $(this).attr('data-appid') });
			});
			jQuery(n).find(".collapse").show();
			jQuery(n).closest(".servicecols").removeClass('col');
      jQuery(n).closest(".servicecols").addClass('col-12');

    	return true;
		}
		else
		{ 
			return false;
		}
  };

	$("#accordion_search_bar").on("keydown", function(e) {
		if( e.which != 8 && e.which != 46 ){
    searchTerm = $(this).val();
    $(".servicecards").each(function() {
      panelContainerId = "#" + $(this).attr("id");
		  //logConsoleMessage("---inside accordion_search_bar on change--" + panelContainerId);

      //Hide not matching
			$( panelContainerId + ":not(:containsCaseInsensitive(" + searchTerm + "))").hide();
			
    	//show which is matching
		  $( panelContainerId + ":containsCaseInsensitive(" + searchTerm + ")").show();
    });
		}
		else{
			$(".servicecards").each(function() {
				$(this).show()
				$(this).find(".collapse").hide();
			});
		}
  });
	
	$("#accordion_search_bar").on("mouseleave", function(e) {
			$(this).val("");
	});
	
	*/
	
		
/*  $(".btn-expand-all").on("click", function() {
		localStorage.expandall=true;
    $(".collapse").collapse("show");
  });
  $(".btn-collapse-all").on("click", function() {
		localStorage.expandall=false;
    $(".collapse").collapse("hide");
  });

  $(".btn-reset-all").on("click", function() {
		localStorage.expandall=false;
    $(".collapse").collapse("hide");
  });
*/

});

