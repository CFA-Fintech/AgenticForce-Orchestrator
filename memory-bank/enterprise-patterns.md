# Enterprise Salesforce Testing Patterns

## Best Practice Hierarchy
1. @testSetup for shared test data
2. TestDataFactory for reusable patterns
3. Test.loadData for bulk scenarios
4. Never use SeeAllData=true

## Implementation Guidelines
- Create test data for each test
- Use proper Test.startTest()/stopTest()
- Verify data isolation between tests
- Maintain >95% code coverage

## Factory Pattern Example
```apex
@isTest
public class TestDataFactory {
    public static Account createAccount(String name) {
        Account acc = new Account(Name = name);
        insert acc;
        return acc;
    }
}
```
