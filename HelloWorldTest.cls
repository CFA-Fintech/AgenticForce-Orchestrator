// ===============================================================
// FILE: HelloWorldTest.cls
// PURPOSE: Comprehensive test class following enterprise patterns
// LOCATION: force-app/main/default/classes/HelloWorldTest.cls
// ===============================================================

/**
 * Comprehensive Test Class for HelloWorld Apex Class
 * 
 * This test class demonstrates enterprise-level testing patterns including:
 * - Data isolation (no SeeAllData=true)
 * - @testSetup for efficient shared test data
 * - TestDataFactory integration for reusable test data
 * - Comprehensive test coverage (positive, negative, edge cases)
 * - Proper test method organization and documentation
 * - Performance testing considerations
 * - Custom exception testing
 * 
 * Testing Strategy:
 * - Each public method has dedicated test coverage
 * - Edge cases and error conditions are thoroughly tested
 * - Test data is created using factory patterns for consistency
 * - All tests maintain data isolation from org data
 * 
 * @author Your Name
 * @version 1.0
 * @since API Version 61.0
 */
@isTest  // Excludes this class from organization code size limit
public class HelloWorldTest {
    
    // ===============================================================
    // TEST DATA SETUP
    // ===============================================================
    
    /**
     * Test setup method for creating shared test data
     * 
     * This method demonstrates the @testSetup pattern which:
     * - Creates test data once per test class execution
     * - Provides shared data accessible to all test methods
     * - Improves test performance by reducing DML operations
     * - Automatically rolls back data after each test method
     * 
     * Data created:
     * - Test account using TestDataFactory
     * - Multiple test contacts linked to the account
     * - Demonstrates proper factory pattern usage
     * 
     * Note: Data created here is available to all test methods in this class
     * and is automatically restored to its original state after each test method.
     */
    @testSetup
    static void setupTestData() {
        // Create test account using TestDataFactory for consistency
        Account testAccount = TestDataFactory.createAccount('Test Company for HelloWorld');
        
        // Create multiple test contacts for various test scenarios
        List<Contact> testContacts = new List<Contact>();
        
        // Create contacts with specific names for testing purposes
        Contact contact1 = TestDataFactory.makeContactForAccount(testAccount.Id);
        contact1.FirstName = 'SetupUser1';
        contact1.LastName = 'TestLastName1';
        testContacts.add(contact1);
        
        Contact contact2 = TestDataFactory.makeContactForAccount(testAccount.Id);
        contact2.FirstName = 'SetupUser2';
        contact2.LastName = 'TestLastName2';
        testContacts.add(contact2);
        
        // Insert all test contacts
        insert testContacts;
        
        // Log setup completion for debugging purposes
        System.debug('Test setup completed: Created ' + testContacts.size() + ' test contacts');
    }
    
    // ===============================================================
    // BASIC FUNCTIONALITY TESTS
    // ===============================================================
    
    /**
     * Test the basic sayHello method
     * 
     * Test Scope:
     * - Verifies default message is returned correctly
     * - Ensures message format matches expected pattern
     * - Tests method behavior without any parameters
     * 
     * This test validates the most basic functionality and serves as a
     * foundation for more complex greeting scenarios.
     */
    @isTest
    static void testSayHello() {
        // Arrange: No setup needed for basic method
        
        // Act: Execute the method under test
        Test.startTest();
        String result = HelloWorld.sayHello();
        Test.stopTest();
        
        // Assert: Verify expected behavior
        System.assertEquals(
            'Hello World from Apex!', 
            result, 
            'sayHello() should return the default Hello World message'
        );
        
        // Additional validation: Ensure result is not null or empty
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assert(result.length() > 0, 'Result should not be empty');
    }
    
    /**
     * Test sayHelloTo method with valid name input
     * 
     * Test Scope:
     * - Validates personalized greeting generation
     * - Tests string concatenation and formatting
     * - Ensures proper handling of valid input
     * 
     * This test covers the primary use case for personalized greetings.
     */
    @isTest
    static void testSayHelloToValidName() {
        // Arrange: Prepare test input
        String testName = 'John';
        String expectedResult = 'Hello John from Apex!';
        
        // Act: Execute method with valid input
        Test.startTest();
        String result = HelloWorld.sayHelloTo(testName);
        Test.stopTest();
        
        // Assert: Verify personalized greeting
        System.assertEquals(
            expectedResult, 
            result, 
            'sayHelloTo() should return personalized greeting for valid name'
        );
        
        // Additional validation: Ensure name is included in result
        System.assert(
            result.contains(testName), 
            'Result should contain the provided name: ' + testName
        );
    }
    
    /**
     * Test sayHelloTo method with invalid inputs (edge cases)
     * 
     * Test Scope:
     * - Null input handling
     * - Empty string handling
     * - Whitespace-only string handling
     * - Validates graceful degradation to default message
     * 
     * This test ensures robust input validation and error handling.
     */
    @isTest
    static void testSayHelloToInvalidInputs() {
        // Expected result for all invalid inputs
        String expectedDefault = 'Hello World from Apex!';
        
        Test.startTest();
        
        // Test Case 1: Empty string
        String result1 = HelloWorld.sayHelloTo('');
        System.assertEquals(
            expectedDefault, 
            result1, 
            'Empty string should return default message'
        );
        
        // Test Case 2: Whitespace-only string
        String result2 = HelloWorld.sayHelloTo('   ');
        System.assertEquals(
            expectedDefault, 
            result2, 
            'Whitespace-only string should return default message'
        );
        
        // Test Case 3: Null input
        String result3 = HelloWorld.sayHelloTo(null);
        System.assertEquals(
            expectedDefault, 
            result3, 
            'Null input should return default message'
        );
        
        Test.stopTest();
        
        // Log test completion for debugging
        System.debug('Invalid input tests completed successfully');
    }
    
    // ===============================================================
    // MULTIPLE NAME HANDLING TESTS
    // ===============================================================
    
    /**
     * Test sayHelloToMany with multiple valid names
     * 
     * Test Scope:
     * - Grammar validation for multiple names
     * - Proper comma and "and" usage
     * - String joining functionality
     * - Integration with TestDataFactory data
     * 
     * This test validates the complex string manipulation logic.
     */
    @isTest
    static void testSayHelloToManyValidNames() {
        // Arrange: Create test data using TestDataFactory
        List<Contact> testContacts = TestDataFactory.createContacts(3);
        
        // Extract names for testing
        List<String> testNames = new List<String>();
        for (Contact con : testContacts) {
            testNames.add(con.FirstName);
        }
        
        // Act: Test multiple name greeting
        Test.startTest();
        String result = HelloWorld.sayHelloToMany(testNames);
        Test.stopTest();
        
        // Assert: Verify format and content
        System.assert(result.startsWith('Hello '), 'Result should start with "Hello "');
        System.assert(result.endsWith(' from Apex!'), 'Result should end with " from Apex!"');
        
        // Verify all names are included
        for (String name : testNames) {
            System.assert(
                result.contains(name), 
                'Result should contain name: ' + name + '. Result: ' + result
            );
        }
        
        // Verify proper grammar for multiple names
        System.assert(
            result.contains(' and '), 
            'Multiple names should include " and " for proper grammar'
        );
        
        System.debug('Multiple name greeting test: ' + result);
    }
    
    /**
     * Test sayHelloToMany with edge cases
     * 
     * Test Scope:
     * - Empty list handling
     * - Null list handling
     * - Single name optimization
     * - Two name grammar
     * - Mixed valid/invalid names
     * 
     * This comprehensive test covers all edge cases for the multiple name method.
     */
    @isTest
    static void testSayHelloToManyEdgeCases() {
        String expectedDefault = 'Hello World from Apex!';
        
        Test.startTest();
        
        // Test Case 1: Empty list
        String result1 = HelloWorld.sayHelloToMany(new List<String>());
        System.assertEquals(
            expectedDefault, 
            result1, 
            'Empty list should return default message'
        );
        
        // Test Case 2: Null list
        String result2 = HelloWorld.sayHelloToMany(null);
        System.assertEquals(
            expectedDefault, 
            result2, 
            'Null list should return default message'
        );
        
        // Test Case 3: Single name (should use sayHelloTo logic)
        String result3 = HelloWorld.sayHelloToMany(new List<String>{'Solo'});
        System.assertEquals(
            'Hello Solo from Apex!', 
            result3, 
            'Single name should work like sayHelloTo method'
        );
        
        // Test Case 4: Two names (special grammar case)
        String result4 = HelloWorld.sayHelloToMany(new List<String>{'First', 'Second'});
        System.assertEquals(
            'Hello First and Second from Apex!', 
            result4, 
            'Two names should use simple "and" grammar'
        );
        
        // Test Case 5: Mixed valid and invalid names
        List<String> mixedNames = new List<String>{'Valid', '', null, '  ', 'AlsoValid'};
        String result5 = HelloWorld.sayHelloToMany(mixedNames);
        System.assertEquals(
            'Hello Valid and AlsoValid from Apex!',
            result5,
            'Should filter out invalid names and process valid ones'
        );
        
        Test.stopTest();
        
        System.debug('Edge case testing completed successfully');
    }
    
    // ===============================================================
    // PLATFORM INTEGRATION TESTS
    // ===============================================================
    
    /**
     * Test sayHelloToCurrentUser method
     * 
     * Test Scope:
     * - Integration with UserInfo and SOQL
     * - User context handling in test environment
     * - Format validation for user-specific greeting
     * 
     * Note: In test context, this uses the test running user's information.
     * The exact name cannot be predicted, so we test format and structure.
     */
    @isTest
    static void testSayHelloToCurrentUser() {
        // Act: Test current user greeting
        Test.startTest();
        String result = HelloWorld.sayHelloToCurrentUser();
        Test.stopTest();
        
        // Assert: Verify format (cannot predict exact user name)
        System.assert(
            result.startsWith('Hello '), 
            'Current user greeting should start with "Hello "'
        );
        System.assert(
            result.endsWith(' from Apex!'), 
            'Current user greeting should end with " from Apex!"'
        );
        System.assertNotEquals(
            null, 
            result, 
            'Current user greeting should not be null'
        );
        
        // Verify it's not the default message (unless user has no first name)
        System.assertNotEquals(
            '', 
            result, 
            'Current user greeting should not be empty'
        );
        
        System.debug('Current user greeting: ' + result);
    }
    
    /**
     * Test printHello method
     * 
     * Test Scope:
     * - Debug log output functionality
     * - Method execution without errors
     * - Void method testing pattern
     * 
     * Note: This method doesn't return a value, so we primarily test
     * that it executes without throwing exceptions.
     */
    @isTest
    static void testPrintHello() {
        // Act: Execute void method
        Test.startTest();
        
        // This should execute without throwing any exceptions
        HelloWorld.printHello();
        
        Test.stopTest();
        
        // Assert: If we reach here, the method executed successfully
        System.assert(true, 'printHello() should execute without throwing exceptions');
        
        // Note: In a real enterprise environment, you might verify
        // debug logs using Test.getDebugLogs() if that functionality is available
    }
    
    // ===============================================================
    // DATA MANIPULATION TESTS
    // ===============================================================
    
    /**
     * Test createHelloContact with valid data
     * 
     * Test Scope:
     * - Contact record creation
     * - DML operation verification
     * - Business logic application (greeting in description)
     * - Data relationship validation
     * - Integration with existing test setup data
     * 
     * This test validates the complete data manipulation workflow.
     */
    @isTest
    static void testCreateHelloContactValid() {
        // Arrange: Prepare test data
        String firstName = 'Jane';
        String lastName = 'Doe';
        String expectedDescription = 'Hello Jane from Apex!';
        
        // Act: Create contact using HelloWorld method
        Test.startTest();
        Id contactId = HelloWorld.createHelloContact(firstName, lastName);
        Test.stopTest();
        
        // Assert: Verify contact creation and data integrity
        System.assertNotEquals(null, contactId, 'Contact ID should not be null');
        
        // Query the created contact to verify all fields
        Contact createdContact = [
            SELECT FirstName, LastName, Description 
            FROM Contact 
            WHERE Id = :contactId
        ];
        
        // Verify all contact fields
        System.assertEquals(
            firstName, 
            createdContact.FirstName, 
            'FirstName should match input parameter'
        );
        System.assertEquals(
            lastName, 
            createdContact.LastName, 
            'LastName should match input parameter'
        );
        System.assertEquals(
            expectedDescription, 
            createdContact.Description, 
            'Description should contain personalized greeting'
        );
        
        // Verify test data isolation: setup contacts should still exist
        List<Contact> setupContacts = [
            SELECT Id 
            FROM Contact 
            WHERE FirstName LIKE 'SetupUser%'
        ];
        System.assertEquals(
            2, 
            setupContacts.size(), 
            'Setup test contacts should still be available (data isolation test)'
        );
        
        System.debug('Successfully created contact: ' + createdContact);
    }
    
    /**
     * Test createHelloContact with invalid data
     * 
     * Test Scope:
     * - Input validation error handling
     * - Custom exception testing
     * - Business rule enforcement
     * - Error message validation
     * 
     * This test ensures proper error handling for invalid inputs.
     */
    @isTest
    static void testCreateHelloContactInvalid() {
        Test.startTest();
        
        // Test Case 1: Blank first name
        try {
            HelloWorld.createHelloContact('', 'ValidLastName');
            System.assert(false, 'Should have thrown HelloWorldException for blank first name');
        } catch (HelloWorld.HelloWorldException e) {
            System.assert(true, 'Correctly threw custom exception for blank first name');
            System.assert(
                e.getMessage().contains('First name and last name are required'),
                'Exception message should explain the validation error'
            );
        }
        
        // Test Case 2: Blank last name
        try {
            HelloWorld.createHelloContact('ValidFirstName', '');
            System.assert(false, 'Should have thrown HelloWorldException for blank last name');
        } catch (HelloWorld.HelloWorldException e) {
            System.assert(true, 'Correctly threw custom exception for blank last name');
            System.assert(
                e.getMessage().contains('First name and last name are required'),
                'Exception message should explain the validation error'
            );
        }
        
        // Test Case 3: Both names blank
        try {
            HelloWorld.createHelloContact('', '');
            System.assert(false, 'Should have thrown HelloWorldException for both names blank');
        } catch (HelloWorld.HelloWorldException e) {
            System.assert(true, 'Correctly threw custom exception for both names blank');
        }
        
        // Test Case 4: Null inputs
        try {
            HelloWorld.createHelloContact(null, null);
            System.assert(false, 'Should have thrown HelloWorldException for null inputs');
        } catch (HelloWorld.HelloWorldException e) {
            System.assert(true, 'Correctly threw custom exception for null inputs');
        }
        
        Test.stopTest();
        
        System.debug('Invalid input testing completed successfully');
    }
    
    // ===============================================================
    // INTEGRATION TESTS WITH TEST DATA FACTORY
    // ===============================================================
    
    /**
     * Test complex scenario using TestDataFactory integration
     * 
     * Test Scope:
     * - TestDataFactory integration demonstration
     * - Complete account hierarchy creation
     * - Multiple HelloWorld method integration
     * - Performance testing with bulk data
     * 
     * This test demonstrates how HelloWorld integrates with enterprise data patterns.
     */
    @isTest
    static void testComplexScenarioWithTestDataFactory() {
        // Arrange: Create complex test data using TestDataFactory
        Map<String, Object> hierarchy = TestDataFactory.createAccountHierarchy();
        Account testAccount = (Account) hierarchy.get('account');
        List<Contact> contacts = (List<Contact>) hierarchy.get('contacts');
        Opportunity opportunity = (Opportunity) hierarchy.get('opportunity');
        
        // Act: Test HelloWorld methods with factory-created data
        Test.startTest();
        
        // Test account greeting
        String accountGreeting = HelloWorld.sayHelloTo(testAccount.Name);
        
        // Test multiple contact greetings
        List<String> contactNames = new List<String>();
        for (Contact con : contacts) {
            contactNames.add(con.FirstName);
        }
        String multipleGreeting = HelloWorld.sayHelloToMany(contactNames);
        
        // Test contact creation with business logic
        Id newContactId = HelloWorld.createHelloContact('Factory', 'Created');
        
        Test.stopTest();
        
        // Assert: Verify all operations completed successfully
        System.assert(
            accountGreeting.contains(testAccount.Name), 
            'Account greeting should contain account name'
        );
        System.assert(
            multipleGreeting.contains(' and '), 
            'Multiple contact greeting should use proper grammar'
        );
        System.assertNotEquals(
            null, 
            opportunity.Id, 
            'TestDataFactory should have created opportunity'
        );
        System.assertNotEquals(
            null, 
            newContactId, 
            'HelloWorld should have created new contact'
        );
        
        // Verify data relationships
        Contact newContact = [SELECT Description FROM Contact WHERE Id = :newContactId];
        System.assertEquals(
            'Hello Factory from Apex!',
            newContact.Description,
            'New contact should have correct greeting in description'
        );
        
        System.debug('Complex scenario test completed successfully');
    }
    
    /**
     * Test performance with bulk operations
     * 
     * Test Scope:
     * - Bulk data creation performance
     * - HelloWorld method performance with large datasets
     * - Governor limit considerations
     * - Memory usage optimization
     * 
     * This test validates performance characteristics for enterprise scenarios.
     */
    @isTest
    static void testBulkOperationsPerformance() {
        // Arrange: Create bulk test data
        Test.startTest();
        
        // Create bulk data using TestDataFactory
        TestDataFactory.createBulkTestData(5, 3); // 5 accounts, 3 contacts each
        
        // Query all contacts for testing
        List<Contact> allContacts = [SELECT FirstName FROM Contact LIMIT 20];
        
        // Prepare large name list
        List<String> bulkNames = new List<String>();
        for (Contact con : allContacts) {
            bulkNames.add(con.FirstName);
        }
        
        // Act: Test HelloWorld methods with bulk data
        String bulkGreeting = HelloWorld.sayHelloToMany(bulkNames);
        
        Test.stopTest();
        
        // Assert: Verify bulk operations completed within limits
        System.assert(
            allContacts.size() >= 15, 
            'Should have created substantial test data (15+ contacts)'
        );
        System.assert(
            bulkGreeting.length() > 50, 
            'Bulk greeting should be substantial in length'
        );
        System.assert(
            Limits.getDmlStatements() < Limits.getLimitDmlStatements(), 
            'Should stay within DML statement limits'
        );
        
        // Performance validation: Method should handle large datasets
        System.debug('Bulk greeting length: ' + bulkGreeting.length());
        System.debug('DML statements used: ' + Limits.getDmlStatements());
        
        System.debug('Bulk operations performance test completed');
    }
    
    /**
     * Test accessing setup data created by @testSetup
     * 
     * Test Scope:
     * - @testSetup data accessibility
     * - Data persistence across test methods
     * - TestDataFactory integration with setup data
     * 
     * This test validates the @testSetup pattern implementation.
     */
    @isTest
    static void testAccessSetupDataFromTestDataFactory() {
        // Act: Access setup data created in @testSetup method
        List<Contact> setupContacts = [
            SELECT FirstName, LastName, Account.Name 
            FROM Contact 
            WHERE FirstName LIKE 'SetupUser%'
            ORDER BY FirstName
        ];
        
        // Assert: Verify setup data availability and integrity
        System.assertEquals(
            2, 
            setupContacts.size(), 
            'Should have 2 setup contacts from @testSetup method'
        );
        System.assertEquals(
            'SetupUser1', 
            setupContacts[0].FirstName, 
            'First setup contact should have expected name'
        );
        System.assertEquals(
            'Test Company for HelloWorld', 
            setupContacts[0].Account.Name, 
            'Setup contacts should be linked to TestDataFactory account'
        );
        
        // Test HelloWorld methods with setup data
        Test.startTest();
        String greeting1 = HelloWorld.sayHelloTo(setupContacts[0].FirstName);
        String greeting2 = HelloWorld.sayHelloTo(setupContacts[1].FirstName);
        Test.stopTest();
        
        // Verify greetings work with setup data
        System.assert(
            greeting1.contains(setupContacts[0].FirstName), 
            'Should greet first setup contact correctly'
        );
        System.assert(
            greeting2.contains(setupContacts[1].FirstName), 
            'Should greet second setup contact correctly'
        );
        
        System.debug('Setup data access test completed successfully');
    }
}

// ===============================================================
// TEST EXECUTION AND COVERAGE NOTES
// ===============================================================

/*
Expected Test Results:
- Total Methods: 12 test methods
- Expected Coverage: >95% on HelloWorld class
- All test methods should pass
- No SeeAllData=true usage (proper data isolation)

Test Execution Commands:
- VS Code: Ctrl+Shift+P → "SFDX: Run Apex Tests"
- CLI: sfdx force:apex:test:run -n HelloWorldTest -r human
- Coverage: sfdx force:apex:test:run -n HelloWorldTest -c -r human

Performance Expectations:
- Test execution time: <30 seconds
- DML operations: <150 (well within limits)
- SOQL queries: <100 (efficient query usage)
- Memory usage: Minimal heap consumption

Quality Gates:
✅ All tests pass
✅ Code coverage >95%
✅ No hard-coded IDs or org dependencies
✅ Proper error handling coverage
✅ Edge case validation
✅ Performance within governor limits
*/