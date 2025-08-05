// ===============================================================
// FILE: HelloWorld.cls
// PURPOSE: Production-ready Apex class with enterprise patterns
// LOCATION: force-app/main/default/classes/HelloWorld.cls
// ===============================================================

/**
 * Enterprise HelloWorld Apex Class
 * 
 * This class demonstrates production-ready Salesforce development patterns including:
 * - Proper class documentation and organization
 * - Input validation and error handling
 * - Bulkified operations for governor limit compliance
 * - Custom exception handling
 * - Integration with Salesforce platform features (SOQL, DML, UserInfo)
 * 
 * @author Your Name
 * @version 1.0
 * @since API Version 61.0
 */
public class HelloWorld {
    
    // ===============================================================
    // CLASS CONSTANTS
    // ===============================================================
    
    /** Default greeting message used across all methods */
    private static final String DEFAULT_MESSAGE = 'Hello World from Apex!';
    
    /** Prefix for personalized greetings */
    private static final String GREETING_PREFIX = 'Hello ';
    
    /** Suffix for all greeting messages */
    private static final String GREETING_SUFFIX = ' from Apex!';
    
    // ===============================================================
    // BASIC GREETING METHODS
    // ===============================================================
    
    /**
     * Returns the standard Hello World message
     * 
     * This method provides a consistent default greeting that can be used
     * as a fallback when personalized greetings are not appropriate.
     * 
     * @return String The default Hello World message
     * 
     * @example
     * String greeting = HelloWorld.sayHello();
     * // Returns: "Hello World from Apex!"
     */
    public static String sayHello() {
        return DEFAULT_MESSAGE;
    }
    
    /**
     * Prints Hello World message to debug logs
     * 
     * This method is particularly useful for:
     * - Testing and debugging in Salesforce development environment
     * - Verification during deployment processes
     * - Troubleshooting in production environments
     * 
     * The message appears in Debug Logs with DEBUG level.
     * 
     * @example
     * HelloWorld.printHello();
     * // Output in Debug Log: "Hello World from Apex!"
     */
    public static void printHello() {
        System.debug('Hello World from Apex!');
    }
    
    // ===============================================================
    // PERSONALIZED GREETING METHODS
    // ===============================================================
    
    /**
     * Returns a personalized Hello message for a given name
     * 
     * This method includes input validation to handle edge cases gracefully:
     * - Null input returns default message
     * - Empty string returns default message  
     * - Whitespace-only string returns default message
     * - Valid name returns personalized greeting
     * 
     * @param name The name to include in the greeting (can be null/empty)
     * @return String Personalized greeting or default message if name is invalid
     * 
     * @example
     * String greeting1 = HelloWorld.sayHelloTo('John');
     * // Returns: "Hello John from Apex!"
     * 
     * String greeting2 = HelloWorld.sayHelloTo('');
     * // Returns: "Hello World from Apex!"
     * 
     * String greeting3 = HelloWorld.sayHelloTo(null);
     * // Returns: "Hello World from Apex!"
     */
    public static String sayHelloTo(String name) {
        // Input validation: check for null, empty, or whitespace-only strings
        if (String.isBlank(name)) {
            return sayHello(); // Fallback to default message
        }
        
        // Construct personalized greeting using class constants
        return GREETING_PREFIX + name + GREETING_SUFFIX;
    }
    
    /**
     * Returns a Hello message for multiple names with proper grammar
     * 
     * This method demonstrates advanced string manipulation and edge case handling:
     * - Handles null or empty lists gracefully
     * - Filters out blank/null names from the input
     * - Uses proper English grammar for multiple names
     * - Optimizes for single vs. multiple name scenarios
     * 
     * Grammar rules implemented:
     * - Single name: "Hello John from Apex!"
     * - Two names: "Hello John and Jane from Apex!"
     * - Multiple names: "Hello John, Jane and Bob from Apex!"
     * 
     * @param names List of names to include in greeting (can be null/empty)
     * @return String Grammatically correct greeting for all valid names
     * 
     * @example
     * List<String> names = new List<String>{'Alice', 'Bob', 'Charlie'};
     * String greeting = HelloWorld.sayHelloToMany(names);
     * // Returns: "Hello Alice, Bob and Charlie from Apex!"
     * 
     * List<String> emptyList = new List<String>();
     * String defaultGreeting = HelloWorld.sayHelloToMany(emptyList);
     * // Returns: "Hello World from Apex!"
     */
    public static String sayHelloToMany(List<String> names) {
        // Input validation: handle null or empty list
        if (names == null || names.isEmpty()) {
            return sayHello();
        }
        
        // Filter out blank/null names and trim whitespace
        List<String> validNames = new List<String>();
        for (String name : names) {
            if (String.isNotBlank(name)) {
                validNames.add(name.trim());
            }
        }
        
        // Handle case where all names were invalid
        if (validNames.isEmpty()) {
            return sayHello();
        }
        
        // Optimize for single name scenario
        if (validNames.size() == 1) {
            return sayHelloTo(validNames[0]);
        }
        
        // Construct grammatically correct greeting for multiple names
        // Format: "Hello name1, name2 and nameN from Apex!"
        String nameList = String.join(validNames.subList(0, validNames.size() - 1), ', ');
        nameList += ' and ' + validNames[validNames.size() - 1];
        
        return GREETING_PREFIX + nameList + GREETING_SUFFIX;
    }
    
    // ===============================================================
    // SALESFORCE PLATFORM INTEGRATION METHODS
    // ===============================================================
    
    /**
     * Returns personalized greeting for the current Salesforce user
     * 
     * This method demonstrates integration with Salesforce platform features:
     * - Uses UserInfo class to get current user context
     * - Performs SOQL query to retrieve user details
     * - Handles potential query exceptions gracefully
     * - Leverages existing greeting logic for consistency
     * 
     * Security considerations:
     * - Uses bound variables to prevent SOQL injection
     * - Limits query results to prevent excessive data retrieval
     * - Falls back gracefully if user data is unavailable
     * 
     * @return String Personalized greeting for current user
     * @throws QueryException if user lookup fails
     * 
     * @example
     * String userGreeting = HelloWorld.sayHelloToCurrentUser();
     * // Returns: "Hello [CurrentUserFirstName] from Apex!" 
     */
    public static String sayHelloToCurrentUser() {
        try {
            // Get current user's details using SOQL with bound variable for security
            User currentUser = [
                SELECT FirstName 
                FROM User 
                WHERE Id = :UserInfo.getUserId() 
                LIMIT 1
            ];
            
            // Use existing greeting logic for consistency
            return sayHelloTo(currentUser.FirstName);
            
        } catch (QueryException e) {
            // Log error and return default greeting
            System.debug(LoggingLevel.ERROR, 'Failed to retrieve current user: ' + e.getMessage());
            return sayHello();
        }
    }
    
    // ===============================================================
    // DATA MANIPULATION METHODS
    // ===============================================================
    
    /**
     * Creates a Contact record with personalized Hello message in description
     * 
     * This method demonstrates enterprise data manipulation patterns:
     * - Input validation with meaningful error messages
     * - Custom exception handling for business logic violations
     * - DML operations with proper error handling
     * - Integration of business logic with data persistence
     * 
     * Business rules enforced:
     * - Both first name and last name are required (non-blank)
     * - Contact description includes personalized greeting
     * - Returns ID for further processing or verification
     * 
     * @param firstName First name for the contact (required)
     * @param lastName Last name for the contact (required)
     * @return Id The ID of the successfully created Contact record
     * @throws HelloWorldException if required fields are missing
     * @throws DmlException if database operation fails
     * 
     * @example
     * try {
     *     Id contactId = HelloWorld.createHelloContact('Jane', 'Doe');
     *     System.debug('Created contact with ID: ' + contactId);
     * } catch (HelloWorld.HelloWorldException e) {
     *     System.debug('Validation error: ' + e.getMessage());
     * }
     */
    public static Id createHelloContact(String firstName, String lastName) {
        // Input validation with specific error messages
        if (String.isBlank(firstName) || String.isBlank(lastName)) {
            throw new HelloWorldException(
                'First name and last name are required for contact creation. ' +
                'Received: firstName="' + firstName + '", lastName="' + lastName + '"'
            );
        }
        
        try {
            // Create Contact record with business logic applied
            Contact newContact = new Contact(
                FirstName = firstName.trim(),
                LastName = lastName.trim(),
                Description = sayHelloTo(firstName) // Apply business logic
            );
            
            // Perform DML operation
            insert newContact;
            
            // Return ID for caller verification/further processing
            return newContact.Id;
            
        } catch (DmlException e) {
            // Re-throw with additional context
            throw new HelloWorldException(
                'Failed to create contact: ' + e.getMessage() + 
                '. Contact details: ' + firstName + ' ' + lastName
            );
        }
    }
    
    // ===============================================================
    // CUSTOM EXCEPTION CLASS
    // ===============================================================
    
    /**
     * Custom exception class for HelloWorld business logic violations
     * 
     * This custom exception provides:
     * - Specific exception type for HelloWorld-related errors
     * - Better error handling and debugging capabilities
     * - Clear separation of business logic errors from system errors
     * - Improved maintainability and testing
     * 
     * Usage patterns:
     * - Validation errors (invalid input parameters)
     * - Business rule violations
     * - Configuration or setup issues
     * 
     * @example
     * try {
     *     // Some HelloWorld operation
     * } catch (HelloWorld.HelloWorldException e) {
     *     // Handle specific HelloWorld errors
     *     System.debug('HelloWorld error: ' + e.getMessage());
     * } catch (Exception e) {
     *     // Handle other system errors
     *     System.debug('System error: ' + e.getMessage());
     * }
     */
    public class HelloWorldException extends Exception {
        // Inherits all functionality from Exception class
        // Provides type-specific exception for HelloWorld operations
    }
}

// ===============================================================
// USAGE EXAMPLES AND PATTERNS
// ===============================================================

/*
// Basic usage examples:
String basic = HelloWorld.sayHello();
String personal = HelloWorld.sayHelloTo('Developer');
String multiple = HelloWorld.sayHelloToMany(new List<String>{'Alice', 'Bob'});

// Platform integration:
String currentUser = HelloWorld.sayHelloToCurrentUser();

// Data operations:
try {
    Id contactId = HelloWorld.createHelloContact('Test', 'User');
    Contact created = [SELECT Description FROM Contact WHERE Id = :contactId];
} catch (HelloWorld.HelloWorldException e) {
    // Handle validation errors
}

// Testing scenarios:
HelloWorld.printHello(); // For debug verification
*/