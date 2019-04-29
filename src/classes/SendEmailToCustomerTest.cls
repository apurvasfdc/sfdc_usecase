@isTest
private class SendEmailToCustomerTest {

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        // insert 10 accounts
        for (Integer i=0;i<5;i++) {
            accounts.add(new Account(name='Account '+i, 
                billingcity='Berlin', billingcountry='Germany', claimStatus__c = 'Approved'));
        }
        insert accounts;
        // find the account just inserted. add contact for each
        Integer count = 0;
        for (Account account : [select id from account]) {
            count++;
            contacts.add(new Contact(firstname='first', 
                lastname='last', accountId=account.id, Level__c = 'Primary', Email = 'test' + count + '@example.com'));
        }
        insert contacts;
    }
    static testmethod void test() {        
        Test.startTest();
        SendEmailToCustomer obj = new SendEmailToCustomer();
        Id batchId = Database.executeBatch(obj);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        List<account> accResults = [select MailSent__c from Account where claimStatus__c = 'Approved'];
        for (Account accResult : accResults) {
            System.assertEquals(True, accResult.MailSent__c);
        }
    }


}
