public class countContactHandler {
    public static void OnAfterInsert(List<Contact> newContacts,Map<Id, contact> oldContactsMap) 
    {
        handleContacts(newContacts,oldContactsMap);
    }
     public static void OnAfterDelete(List<Contact> newContacts, Map<Id, contact> oldContactsMap)
    {
        handleDeleteContacts(newContacts,oldContactsMap);//change name
    }
    public static void handleContacts(List<Contact> newContacts, Map<Id, contact> oldContactsMap) { //Contact Map
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Account> accountMap = new Map<Id, Account>();
        //system.debug(oldAccountsMap);
        // Identify the account ids related to the contacts
        for (Contact contact : newContacts) {
            accountIds.add(contact.AccountId);
        }
        // Retrieve the accounts and update the number of contacts field
        if (!accountIds.isEmpty()) {
            accountMap = new Map<Id, Account>([SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN :accountIds]);

            for (Contact contact : newContacts) {
                Account account = accountMap.get(contact.AccountId);
                //system.debug(account);
                
                //system.debug(account.Number_of_Contacts__C);
                if (account != null) {
                    account.Number_of_Contacts__c++;
                    
                }
            }
            update accountMap.values();
        }
    }
    
    public static void handleDeleteContacts(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Account> accountMap = new Map<Id, Account>();
        
        for (Contact contact : oldContactsMap.values()) {
                accountIds.add(contact.AccountId);
            }
        
        if (!accountIds.isEmpty()) {
            accountMap = new Map<Id, Account>([SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN :accountIds]);
            for (Contact contact : newContacts) {
                Account account = accountMap.get(contact.AccountId);
                if (account != null) {
                    account.Number_of_Contacts__c--;
                    if(account.Number_of_Contacts__c<=0){
                         account.Number_of_Contacts__c=0;
                        
                    }
                    
                }
            }
            update accountMap.values();
        }
    }
}