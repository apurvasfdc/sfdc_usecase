@isTest
private class policyPaymentCalloutTest {

	@isTest static  void testGetCallout() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('policyPaymentCalloutMock');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        Id recordId = '5007F00000iiS1xQAE'; //dummy Id value to pass as method argument
        policyPaymentCallout.policyItem result = policyPaymentCallout.makeGetCallout(recordId);
        // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');
        System.assertEquals('12345678', result.customerAccountId,
          'The customerAccountId does not mactch.');
        // Verify content type   
        System.assertEquals('1001', result.policyNumber);
        System.assertEquals('2500', result.previousPaymentAmount);
        System.assertEquals('28/03/2019', result.previousPaymentDate);
        System.assertEquals('2500', result.nextPaymentAmount);
        System.assertEquals('28/04/2019', result.nextPaymentDueDate);
        System.assertEquals('25/04/2019', result.LastSyncDate);
        
    } 
    
    
    public static testmethod void testGetCallout2() {
        RestApiRequestMock fakeResponse = new RestApiRequestMock(200,
                                                 'Complete',
                                                 '{"customerAccountId": "12345678","policyNumber": "1001","previousPaymentAmount": "2500",' + 
                                                 '"previousPaymentDate": "28/03/2019","nextPaymentAmount": "2500", ' +
                                                 '"nextPaymentDueDate": "28/04/2019","LastSyncDate": "25/04/2019"}',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Id recordId = '5007F00000iiS1xQAE'; //dummy Id value to pass as method argument
        policyPaymentCallout.policyItem result = policyPaymentCallout.makeGetCallout(recordId);
         // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');
        System.assertEquals('12345678', result.customerAccountId,
          'The customerAccountId does not mactch.');
        // Verify content type   
        System.assertEquals('1001', result.policyNumber);
        System.assertEquals('2500', result.previousPaymentAmount);
        System.assertEquals('28/03/2019', result.previousPaymentDate);
        System.assertEquals('2500', result.nextPaymentAmount);
        System.assertEquals('28/04/2019', result.nextPaymentDueDate);
        System.assertEquals('25/04/2019', result.LastSyncDate);
    }
    
    public static testmethod void testGetCalloutFailure() {
        RestApiRequestMock fakeResponse = new RestApiRequestMock(502,
                                                 'Complete',
                                                 '{"error":{"status":502,"message":"Bad gateway."}}',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Id recordId = '5007F00000iiS1xQAE'; //dummy Id value to pass as method argument
        policyPaymentCallout.policyItem result = policyPaymentCallout.makeGetCallout(recordId);
         // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');
        // Verify content type   
        System.assertNotEquals(null, result.errorMessage);
        System.assertEquals(policyPaymentCallout.errorMessage, result.errorMessage);
    }

}