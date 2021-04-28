using Toybox.Communications;

module Actions {
    var options = {
        :method => Communications.HTTP_REQUEST_METHOD_POST,
        :headers => {},
        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
    };

    function triggerHorn() {
        Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/actions/triggerHorn", null, options, null);
    }
}