# Salesforce Learning Integration Project

## Overview
This project demonstrates enterprise-level Salesforce development patterns including:
- Apex class development
- Comprehensive testing strategies
- Test data management
- Bulk data handling with CSV

## Architecture
- HelloWorld.cls: Main business logic
- HelloWorldTest.cls: Comprehensive test coverage
- TestDataFactory.cls: Reusable test data patterns

## Testing Strategy
- @testSetup for shared test data
- TestDataFactory for reusable patterns
- Test.loadData for bulk CSV scenarios
- No SeeAllData=true (data isolation)
