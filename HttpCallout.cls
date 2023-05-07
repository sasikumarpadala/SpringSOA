public class HttpCallout {
    
    public static void makeGetRequest() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('Received the following response as a Map:');
            System.debug(responseMap);
            System.debug('Received the following response for Object args:');
            System.debug(responseMap.get('args'));
        } else {
            System.debug('Received an error response with status code ' + response.getStatusCode());
        }
    }
}