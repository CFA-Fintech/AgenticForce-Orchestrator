# Enterprise Salesforce Development Patterns

## Apex Development Standards

### Service Layer Pattern
- Separate business logic from triggers and controllers
- Use static methods for reusable operations
- Implement proper error handling and rollback strategies
- Follow bulkification patterns for all operations

### Security Patterns
- Always check CRUD/FLS permissions before database operations
- Use `WITH SECURITY_ENFORCED` in SOQL queries
- Implement input validation and sanitization
- Follow principle of least privilege
- Use custom exceptions for business logic errors

### Testing Patterns (Enhanced)
- Use @testSetup for shared test data across test methods
- Implement TestDataFactory for reusable, consistent test data
- Achieve >85% code coverage with meaningful assertions
- Test both positive and negative scenarios
- Use Test.startTest()/stopTest() for governor limit isolation
- Never use SeeAllData=true in production code

### Performance Patterns
- No SOQL queries inside loops
- Bulkify all DML operations using Lists and Maps
- Use selective queries with specific fields only
- Implement efficient caching strategies
- Monitor governor limits proactively

### Error Handling Patterns
- Use try-catch blocks with specific exception types
- Implement rollback strategies with Database.Savepoint
- Log errors appropriately without exposing sensitive data
- Provide user-friendly error messages
- Use custom exception classes for business logic

## Lightning Web Component Standards

### Component Architecture
- Follow component composition patterns
- Use proper event handling and communication
- Implement proper error boundaries
- Follow accessibility standards (WCAG 2.1)
- Use Lightning Design System (LDS) components

### LWC Security
- Use @wire with proper error handling
- Validate all user inputs on both client and server
- Follow Content Security Policy (CSP) guidelines
- Implement proper permission checks in Apex controllers

## Data Architecture Patterns

### Custom Object Design
- Use descriptive API names with proper namespacing
- Implement validation rules for data integrity
- Design for scalability and performance
- Follow field naming conventions consistently

### Relationship Design
- Use lookup relationships for loose coupling
- Master-detail for tight data relationships
- Avoid deep relationship queries (>5 levels)
- Implement proper sharing and security models
