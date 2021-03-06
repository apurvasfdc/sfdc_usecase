global class SendEmailToCustomer implements Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator(
            [SELECT ID, claimStatus__c, MailSent__c, name,
             (Select Name, Email from contacts where Level__c = 'Primary' ) FROM Account
             Where claimStatus__c = 'Approved' and MailSent__c != true]
        );
    }
    global void execute(Database.BatchableContext bc, List<Account> scope)
    {
        Id contactId; //Id of the contact for the mail to be sent
        String contactName; //Name of the contact to whom mail is to be send
        String contactEmail; // email Id of the contact
        List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();

        // process each batch of records
        for (Account accountRecord : scope) {
            List<Id> contactList = new List<Id> ();
            for (Contact con: accountRecord.Contacts) {
                contactId = con.Id;
                contactName = con.Name;
                contactEmail = con.Email;
            }
            system.debug('contactEmail--'+contactEmail);
           If (accountRecord.claimStatus__c == 'Approved' && accountRecord.MailSent__c == false && contactEmail != null)
           {
               Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
               email.setToAddresses(new String[] {contactEmail});
               email.setSaveAsActivity(true); // set to true so that it is available in the record page
               email.setTargetObjectId(contactId);
               email.setSubject(accountRecord.Name + 'Your Claim Approved');
               String messageBody = '<html><body>Hi ' + contactName + ',<br>Your claim is approved. You will receive the approved amount in 3-5 days.<br></body></html>';
               email.setHtmlBody(messageBody);
               allMails.add(email);

               System.debug('Mail not sent but update field');
               accountRecord.MailSent__c = true;

           }
        }
        
           Messaging.sendEmail(allMails);
           System.debug('Update');
           update scope;
       
    }
    
    global void finish(Database.BatchableContext bc){
        
    }    
}
