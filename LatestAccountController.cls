public with sharing class LatestAccountController {
    @AuraEnabled
    public static List<Account> getRecentAccounts() {
        return [SELECT Id, Name, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT 10];
    }
}