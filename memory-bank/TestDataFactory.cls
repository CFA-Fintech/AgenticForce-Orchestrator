/**
 * Test Data Factory - Common utility class for creating test data
 * This class is excluded from organization code size limit due to @isTest annotation
 */
@isTest
public class TestDataFactory {
    
    /**
     * Creates test accounts with optional contacts
     * @param numAccounts Number of accounts to create
     * @param numContactsPerAccount Number of contacts per account
     * @return List of created accounts with contacts populated
     */
    public static List<Account> createAccountsWithContacts(Integer numAccounts, Integer numContactsPerAccount) {
        List<Account> accounts = new List<Account>();
        
        // Create accounts
        for (Integer i = 0; i < numAccounts; i++) {
            accounts.add(new Account(
                Name = 'Test Account ' + i,
                Phone = '555-000-' + String.valueOf(i).leftPad(4, '0'),
                Website = 'https://testaccount' + i + '.example.com',
                Industry = 'Technology'
            ));
        }
        insert accounts;
        
        // Create contacts if requested
        if (numContactsPerAccount > 0) {
            List<Contact> contacts = new List<Contact>();
            
            for (Integer accIndex = 0; accIndex < accounts.size(); accIndex++) {
                Account acc = accounts[accIndex];
                
                for (Integer contactIndex = 0; contactIndex < numContactsPerAccount; contactIndex++) {
                    contacts.add(new Contact(
                        FirstName = 'Contact' + contactIndex,
                        LastName = 'TestLast' + accIndex + '_' + contactIndex,
                        Email = 'contact' + accIndex + '_' + contactIndex + '@testaccount.com',
                        Phone = '555-111-' + String.valueOf(accIndex * 100 + contactIndex).leftPad(4, '0'),
                        AccountId = acc.Id
                    ));
                }
            }
            insert contacts;
        }
        
        return accounts;
    }
    
    /**
     * Creates test contacts without accounts
     * @param numContacts Number of contacts to create
     * @return List of created contacts
     */
    public static List<Contact> createContacts(Integer numContacts) {
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i = 0; i < numContacts; i++) {
            contacts.add(new Contact(
                FirstName = 'TestFirst' + i,
                LastName = 'TestLast' + i,
                Email = 'test' + i + '@example.com',
                Phone = '555-222-' + String.valueOf(i).leftPad(4, '0')
            ));
        }
        insert contacts;
        
        return contacts;
    }
    
    /**
     * Creates test users (limited in test context)
     * @param numUsers Number of users to create
     * @param profileName Profile name for the users
     * @return List of created users
     */
    public static List<User> createTestUsers(Integer numUsers, String profileName) {
        // Get the profile
        Profile testProfile = [SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1];
        
        List<User> users = new List<User>();
        String timestamp = String.valueOf(System.currentTimeMillis());
        
        for (Integer i = 0; i < numUsers; i++) {
            users.add(new User(
                FirstName = 'Test',
                LastName = 'User' + i,
                Email = 'testuser' + i + timestamp + '@example.com',
                Username = 'testuser' + i + timestamp + '@example.com.test',
                Alias = 'tuser' + i,
                ProfileId = testProfile.Id,
                TimeZoneSidKey = 'America/New_York',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US'
            ));
        }
        insert users;
        
        return users;
    }
    
    /**
     * Creates test data for HelloWorld class testing
     * @return Map containing different types of test data
     */
    public static Map<String, Object> createHelloWorldTestData() {
        Map<String, Object> testData = new Map<String, Object>();
        
        // Create accounts for testing
        List<Account> accounts = createAccountsWithContacts(2, 1);
        testData.put('accounts', accounts);
        
        // Create standalone contacts
        List<Contact> contacts = createContacts(3);
        testData.put('contacts', contacts);
        
        // Create name lists for testing
        List<String> nameList = new List<String>{'Alice', 'Bob', 'Charlie', 'Diana'};
        testData.put('names', nameList);
        
        return testData;
    }
    
    /**
     * Creates test data from CSV-like structure (simulates Test.loadData pattern)
     * @param csvData String containing CSV-formatted test data
     * @return List of Account records
     */
    public static List<Account> createAccountsFromCSVData(String csvData) {
        List<Account> accounts = new List<Account>();
        List<String> lines = csvData.split('\n');
        
        if (lines.size() <= 1) {
            return accounts; // No data rows
        }
        
        // Parse header (first line)
        List<String> headers = lines[0].split(',');
        
        // Parse data rows
        for (Integer i = 1; i < lines.size(); i++) {
            List<String> values = lines[i].split(',');
            Account acc = new Account();
            
            for (Integer j = 0; j < headers.size() && j < values.size(); j++) {
                String header = headers[j].trim();
                String value = values[j].trim();
                
                if (header.equalsIgnoreCase('Name')) {
                    acc.Name = value;
                } else if (header.equalsIgnoreCase('Phone')) {
                    acc.Phone = value;
                } else if (header.equalsIgnoreCase('Website')) {
                    acc.Website = value;
                } else if (header.equalsIgnoreCase('Industry')) {
                    acc.Industry = value;
                }
                // Add more field mappings as needed
            }
            
            if (String.isNotBlank(acc.Name)) {
                accounts.add(acc);
            }
        }
        
        if (!accounts.isEmpty()) {
            insert accounts;
        }
        
        return accounts;
    }
}