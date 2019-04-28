/**
 * This class make rest api call to the external system to fetch the payment details
 * 
 * @authour - Apurva
 * @ticket  - SF_Use_Case
 */
public class policyPaymentCallout {
    public static string errorMessage = 'Sorry, There is an error retrieving payment details. Please comeback later';
    public class policyItem {
        public String customerAccountId;
        public String policyNumber;
        public String previousPaymentAmount;
        public String previousPaymentDate;
        public String nextPaymentAmount ;
        public String nextPaymentDueDate;
        public String LastSyncDate;
        public String errorMessage;
    }

    /**
     * This method is to make GET call to fetch details like amount, customer Account Number etc.
     * 
     * @authour - Apurva
     * @param   - Id
     * 
     * @return  - HttpResponse response
     */
    public static policyItem makeGetCallout(Id recordId) {
        policyItem results;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //request.setEndpoint('http://www.mocky.io/v2/5cbb212b310000fc174d74ae');
        //request.setEndpoint('http://www.mocky.io/v2/5cbc5945320000460e80d85f');
        request.setEndpoint('http://www.mocky.io/v2/5cc5bd8e2e00004700594af1');
        request.setMethod('GET');
        try {
            HttpResponse response = http.send(request);
            system.debug('response' + response);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) {
                //Deserializes the JSON string
                results = (policyItem) JSON.deserialize (response.getBody(), policyItem.class);
            } else {
                results = new policyItem();
                results.errorMessage = policyPaymentCallout.errorMessage;
            }
        } catch (Exception e) {
            results = new policyItem();
            results.errorMessage = policyPaymentCallout.errorMessage;
        }
        return results;
    }

}