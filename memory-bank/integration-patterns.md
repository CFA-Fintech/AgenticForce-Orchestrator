# Integration Patterns for Enterprise Salesforce

## API Integration Standards

### REST API Patterns
- Use named credentials for external authentication
- Implement proper timeout and retry mechanisms
- Use asynchronous patterns (@future, Queueable) for long-running operations
- Implement proper error handling and logging

### Event-Driven Architecture
- Use Platform Events for decoupled communication
- Implement Change Data Capture for data synchronization
- Use Streaming API for real-time updates
- Design for eventual consistency patterns

### Batch Processing Patterns
- Use Batch Apex for large data volumes (>200 records)
- Implement proper checkpointing and restart logic
- Use Database.Stateful for maintaining state across batches
- Monitor batch job status and handle failures gracefully

## Security Integration Patterns

### Authentication Patterns
- Use OAuth 2.0 for external system authentication
- Implement JWT tokens for system-to-system integration
- Use named credentials to avoid hardcoded secrets
- Implement proper token refresh mechanisms

### Data Security
- Encrypt sensitive data at rest and in transit
- Use Platform Encryption for field-level security
- Implement data masking for non-production environments
- Follow data residency and compliance requirements

## AI Integration Patterns

### Claude/AI Assistant Integration
- Maintain persistent context through memory-bank/ files
- Use structured prompts for consistent AI responses
- Implement proper validation of AI-generated code
- Follow enterprise AI governance policies

### Cursor IDE Integration
- Use .cursor/rules/ for project-specific AI guidelines
- Implement proper code review workflows with AI assistance
- Maintain human oversight for all AI-generated changes
- Follow security guidelines for AI tool usage
