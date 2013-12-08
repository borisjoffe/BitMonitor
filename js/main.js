var startTime;
var checkTime;

//Initialize function
var init = function () {
    // TODO:: Do your initialization job
    console.log("init() called");

    // add eventListener for tizenhwkey
    document.addEventListener('tizenhwkey', function(e) {
        if(e.keyName == "back")
            tizen.application.getCurrentApplication().exit();
    });

	/*
	// Defines the data to be used when this process is launched by notification service.
	var service = new tizen.ApplicationControl("http://tizen.org/appcontrol/operation/push_test");

	// Defines the error callback.
	function errorCallback(response) {
		console.log( 'The following error occurred: ' +  response.name);
	}

	// Defines the registration success callback
	function registerSuccessCallback(id) {
		console.log("Registration succeeded with id: " + id);
	}

	// Requests registration.
	tizen.push.registerService(service, registerSuccessCallback, errorCallback);
	*/
};
// window.onload can work without <body onload="">
window.onload = init;

function startTime() {
    var today = new Date();
    var h = today.getHours();

    var m = today.getMinutes();
    var s = today.getSeconds();
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('divbutton1').innerHTML="Current time: " + h + ":" + m + ":" + s;
    t = setTimeout(startTime, 250);
}

function checkTime(i) {
    if (i < 10) {
        i="0" + i;
    }
    return i;
}
