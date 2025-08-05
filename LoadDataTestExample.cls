/**
 * Enhanced version of your LoadDataTestExample
 * Builds on your basic pattern with production-ready features
 */
@isTest
private class LoadDataTestExample {
    
    /**
     * Your original example - enhanced with more assertions
     */
    @isTest 
    static void testBulkAccounts() {
        Test.startTest();
        
        // Load accounts from your CSV static resource
        List<Account> testAccounts = (List<Account>) Test.loadData(Account.sObjectType, 'TestAccounts');
        
        Test.stopTest();
        
        // Your original assertion
        System.assertEquals(3, testAccounts.size(), 'Should load 3 accounts from CSV');
        
        // Enhanced assertions for data quality
        System.assertEquals('Acme Inc', testAccounts[0].Name, 'First account name should match CSV');
        System.assertEquals('Technology', testAccounts[0].Industry, 'Industry should be loaded correctly');
        System.assertEquals('Prospect', testAccounts[0].Type, 'Type should be loaded correctly');
        
        // Verify we can query the loaded data
        List<Account> techAccounts = [SELECT Id, Name FROM Account WHERE Industry = 'Technology'];
        System.assertEquals(2, techAccounts.size(), 'Should find 2 technology accounts');
        
        // Test with HelloWorld class
        String greeting = HelloWorld.sayHelloTo(testAccounts[0].Name);
        System.assertEquals('Hello Acme Inc from Apex!', greeting, 'Should greet account correctly');
        
        System.debug('Successfully loaded accounts: ');
        for (Account acc : testAccounts) {
            System.debug('- ' + acc.Name + ' (' + acc.Industry + ', ' + acc.Type + ')');
        }
    }
    
    /**
     * Show how to use loaded data with HelloWorld methods
     */
    @isTest
    static void testHelloWorldWithLoadedData() {
        // Load your CSV data
        List<Account> testAccounts = (List<Account>) Test.loadData(Account.sObjectType, 'TestAccounts');
        
        Test.startTest();
        
        // Extract account names for HelloWorld testing
        List<String> accountNames = new List<String>();
        for (Account acc : testAccounts) {
            accountNames.add(acc.Name);
        }
        
        // Test HelloWorld methods with your CSV data
        String singleGreeting = HelloWorld.sayHelloTo(accountNames[0]);
        String multipleGreeting = HelloWorld.sayHelloToMany(accountNames);
        
        Test.stopTest();
        
        // Verify greetings work with loaded data
        System.assertEquals('Hello Acme Inc from Apex!', singleGreeting, 'Single greeting should work');
        System.assert(multipleGreeting.contains('Acme Inc'), 'Multiple greeting should contain first account');
        System.assert(multipleGreeting.contains('Global Media'), 'Multiple greeting should contain second account');
        System.assert(multipleGreeting.contains('and'), 'Multiple greeting should use proper grammar');
    }
    
    /**
     * Combine Test.loadData with TestDataFactory
     */
    @isTest
    static void testHybridApproach() {
        // Use your CSV for bulk accounts
        List<Account> csvAccounts = (List<Account>) Test.loadData(Account.sObjectType, 'TestAccounts');
        
        // Use TestDataFactory for specific contacts
        Contact testContact = TestDataFactory.createContact();
        testContact.AccountId = csvAccounts[0].Id; // Link to CSV account
        update testContact;
        
        Test.startTest();
        
        // Test HelloWorld with both data sources
        String accountGreeting = HelloWorld.sayHelloTo(csvAccounts[0].Name);
        String contactGreeting = HelloWorld.sayHelloTo(testContact.FirstName);
        
        Test.stopTest();
        
        // Verify both approaches work together
        System.assert(accountGreeting.contains('Acme Inc'), 'Should greet CSV account');
        System.assert(contactGreeting.contains(testContact.FirstName), 'Should greet factory contact');
        
        // Verify relationship
        Contact linkedContact = [SELECT AccountId, Account.Name FROM Contact WHERE Id = :testContact.Id];
        System.assertEquals('Acme Inc', linkedContact.Account.Name, 'Contact should be linked to CSV account');
    }
    
    /**
     * Error handling for your CSV approach
     */
    @isTest
    static void testCSVErrorHandling() {
        Test.startTest();
        
        // Test successful load first
        List<Account> accounts = (List<Account>) Test.loadData(Account.sObjectType, 'TestAccounts');
        System.assert(accounts.size() > 0, 'Should successfully load valid CSV');
        
        // Test error case
        try {
            List<Account> invalidAccounts = (List<Account>) Test.loadData(Account.sObjectType, 'NonExistentCSV');
            System.assert(false, 'Should throw error for missing CSV');
        } catch (Exception e) {
            System.assert(true, 'Correctly handled missing CSV file');
        }
        
        Test.stopTest();
    }
    
    /**
     * Performance test with your CSV pattern
     */
    @isTest
    static void testCSVPerformance() {
        // Measure performance of CSV loading
        Datetime startTime = Datetime.now();
        
        Test.startTest();
        
        List<Account> accounts = (List<Account>) Test.loadData(Account.sObjectType, 'TestAccounts');
        
        // Perform operations on loaded data
        for (Account acc : accounts) {
            acc.Description = 'Processed at ' + Datetime.now();
        }
        update accounts;
        
        Test.stopTest();
        
        Datetime endTime = Datetime.now();
        Long executionTime = endTime.getTime() - startTime.getTime();
        
        // Verify performance and data integrity
        System.assert(executionTime < 5000, 'CSV loading should complete within 5 seconds');
        System.assertEquals(3, accounts.size(), 'Should process all CSV accounts');
        
        // Verify updates persisted in test context
        List<Account> updatedAccounts = [SELECT Description FROM Account WHERE Description LIKE 'Processed at%'];
        System.assertEquals(3, updatedAccounts.size(), 'All accounts should be updated');
    }
}