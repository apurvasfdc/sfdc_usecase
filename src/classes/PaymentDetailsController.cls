/**
* This class fetch the payment related info to be displayed
* 
* @ticket - SF use case
*/
public class PaymentDetailsController {
   /**
    * This method fetches the payment details
    *
    * @return - policies
    */
   @auraEnabled
    public Static Map<String, String> getPaymentDetails()
    {
        Id recordId = null;
        policyPaymentCallout.policyItem response = policyPaymentCallout.makeGetCallout(recordId);
        
        Map<String, String> policies = new Map<String, String>();
       
            policies.put('customerAccountId', response.customerAccountId);
            policies.put('policyNumber', response.policyNumber);
            policies.put('previousPaymentAmount', response.previousPaymentAmount);
            policies.put('previousPaymentDate', response.previousPaymentDate);
            policies.put('LastSyncDate', response.LastSyncDate);
            policies.put('nextPaymentDueDate', response.nextPaymentDueDate);
         return policies;
    }

}