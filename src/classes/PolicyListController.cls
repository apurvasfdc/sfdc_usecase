/**
 * This class fetches the policy details
 */
public class PolicyListController {
	/**
    * This method fetches the policy details
    *
    * @return - List<Policy__c>
    */
    @AuraEnabled
	public static List<Policy__c> getPolicies(Id recordId) {
   		return [Select Id, Name, Policy_Number__c , Premium__c ,Term__c, Status__c From Policy__c  Where Case__c = :recordId];
	}

}