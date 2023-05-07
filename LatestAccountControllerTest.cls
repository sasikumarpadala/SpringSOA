@isTest
private class LatestAccountControllerTest {
    @testSetup
    static void setupTestData() {
        // create test data
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<20; i++){
            accounts.add(new Account(Name='Test Account ' + i,AccountNumber='439498'+i));
        }
        insert accounts;
    }
    @isTest
    static void testGetRecentAccounts() {
        List<Account> recentAccounts = LatestAccountController.getRecentAccounts();
        
        // assert that the list of accounts returned is not null
        System.assertNotEquals(null, recentAccounts);
        
        // assert that the list contains the 10 most recently created accounts
        List<Account> expectedAccounts = [SELECT Id, Name, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT 10];
        System.assertEquals(expectedAccounts.size(), recentAccounts.size());
        for (Integer i = 0; i < expectedAccounts.size(); i++) {
            System.assertEquals(expectedAccounts[i].Id, recentAccounts[i].Id);
            System.assertEquals(expectedAccounts[i].Name, recentAccounts[i].Name);
            System.assertEquals(expectedAccounts[i].CreatedDate, recentAccounts[i].CreatedDate);
        }
    }
}