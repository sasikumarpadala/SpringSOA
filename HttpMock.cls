public class HttpMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('{"args":{"foo1"="bar1","foo2"="bar2"}}');
        return response;
    }
}