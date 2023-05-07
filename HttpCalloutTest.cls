@isTest
private class HttpCalloutTest {
    @isTest
    static void testMakeGetRequest() {
        Test.setMock(HttpCalloutMock.class, new HttpMock());
        HttpCallout.makeGetRequest();
    }
}