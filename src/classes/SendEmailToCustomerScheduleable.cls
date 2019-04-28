global class SendEmailToCustomerScheduleable implements Schedulable {
   global void execute(SchedulableContext sc) {
      SendEmailToCustomer b = new SendEmailToCustomer(); 
      database.executebatch(b);
   }
}