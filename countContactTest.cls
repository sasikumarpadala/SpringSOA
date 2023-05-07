@isTest
public class countContactTest {
    
    @testSetup
    static void setup() {
        // Create test accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            accounts.add(new Account(Name='Test Account ' + i,AccountNumber = '43324'+i, Number_of_Contacts__c=0));
        }
        insert accounts;
        system.debug(accounts);
        // Create test contacts associated with the accounts
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(FirstName='Test', LastName='Contact ' + i, AccountId=accounts[math.mod(i,3)].Id));
        	system.debug(contacts[i]);
        }
        
        insert contacts;
    }
    
    @isTest
    static void testAfterInsertContacts() {
        // Retrieve test contacts and accounts
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact];
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        
        // Call the handleContacts method and verify the number of contacts for each account
        Test.startTest();
        update accounts;
        Test.stopTest();
        
        accounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        system.debug(accounts);
        System.assertEquals(2, accounts[0].Number_of_Contacts__c); 
        System.assertEquals(2, accounts[1].Number_of_Contacts__c); 
        System.assertEquals(1, accounts[2].Number_of_Contacts__c); 
    }
    
    @isTest
    static void testAfterDeleteContacts() {
        // Retrieve test contacts and accounts
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact LIMIT 3];
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c FROM Account ];
        
        // Call the handleDeleteContacts method and verify the number of contacts for each account
        Test.startTest();
        delete contacts;
        Test.stopTest();
        
        accounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        System.assertEquals(1, accounts[0].Number_of_Contacts__c);
        System.assertEquals(1, accounts[1].Number_of_Contacts__c);
        System.assertEquals(0, accounts[2].Number_of_Contacts__c);
    }
}