
# AgenticForce Orchestrator

[![Build Status](https://github.com/CFA-Fintech/AgenticForce-Orchestrator/actions/workflows/validate.yml/badge.svg)](https://github.com/CFA-Fintech/AgenticForce-Orchestrator/actions)
[![Version](https://img.shields.io/badge/version-1.1.0-blue)](https://github.com/CFA-Fintech/AgenticForce-Orchestrator/releases)
[![Salesforce API](https://img.shields.io/badge/Salesforce%20API-v59.0-blue)](https://developer.salesforce.com)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

Enterprise Salesforce development template optimized for AI-native workflows with Claude, Cursor, and Cline integration.

## About

This enterprise-grade Salesforce development project template incorporates the latest 2024-2025 best practices, including:

- **AI-Assisted Development**: Cursor IDE with Claude integration and persistent memory banks
- **Modern Testing Patterns**: @testSetup with TestDataFactory and >85% coverage requirements
- **Enterprise Security**: CRUD/FLS enforcement and comprehensive permission checking
- **CI/CD Automation**: GitHub Actions with automated validation and deployment
- **Comprehensive Documentation**: Both human-facing and AI-specific context management

## Quick Start

### Prerequisites
- Salesforce org (Developer, Enterprise, or Sandbox)
- Salesforce CLI v2 (`sf` command) - [Install Guide](https://developer.salesforce.com/tools/sfdxcli)
- Node.js LTS version (18+)
- Git for version control
- VS Code with Salesforce Extension Pack (recommended)
- Cursor IDE (optional, for enhanced AI assistance)

### Installation

```bash
# Clone the repository
git clone https://github.com/CFA-Fintech/AgenticForce-Orchestrator.git
cd AgenticForce-Orchestrator

# Install dependencies
npm install

# Authenticate to your Salesforce org
sf org login web --alias dev-org

# Deploy to org with comprehensive testing
sf project deploy start --source-dir force-app/main/default --target-org dev-org --test-level RunLocalTests --wait 10

# Verify deployment
sf project deploy report --target-org dev-org

```

### AI-Assisted Development Setup

```bash
# Install Salesforce MCP server (if using Cursor with Claude)
npm install @salesforce/mcp

# Review AI configuration files
cat .cursor/rules/core.mdc
cat memory-bank/enterprise-patterns.md

# Start development with AI assistance
cursor .  # Opens project in Cursor IDE

```

## Architecture

This project follows enterprise Salesforce architecture patterns:

### **Service Layer Pattern**

- Business logic separated from triggers and controllers
- Reusable static methods with proper error handling
- Comprehensive bulkification for all operations

### **Security-First Design**

- CRUD/FLS permission checks before all database operations
- `WITH SECURITY_ENFORCED` SOQL queries
- Input validation and proper exception handling

### **AI-Native Development**

- Persistent context through memory-bank/ files
- Consistent AI assistance with .cursor/rules/ guidelines
- Human oversight with automated quality validation

### **Comprehensive Testing**

- @testSetup patterns for efficient test data creation
- TestDataFactory for reusable, consistent test data
- 85% code coverage with meaningful assertions

## Project Structure

```
├── .cursor/rules/           # AI coding guidelines and context
├── memory-bank/            # Persistent AI knowledge base
├── force-app/main/default/ # Salesforce metadata
├── docs/onboarding/        # Human-facing documentation
├── data/                   # Sample CSV data for testing
├── scripts/deploy/         # Deployment automation
├── .github/workflows/      # CI/CD validation
├── CLAUDE.md              # Comprehensive AI project context
└── README.md              # This file

```

## Core Features

### **Salesforce Components**

- **Custom Objects**: Project__c with validation rules and automation
- **Apex Classes**: HelloWorld (13KB), TestDataFactory, LoadDataTestExample (6KB)
- **Lightning Web Components**: projectCard for modern, responsive UI
- **Automation**: Flag_Overdue_Projects flow for business logic
- **Security**: ProjectAdmin permission set with granular access control

### **AI Development Environment**

- **Context Management**: .cursor/rules/ for AI-specific guidelines
- **Knowledge Base**: memory-bank/ with enterprise patterns and integration guides
- **Quality Assurance**: Automated validation of AI-generated code

### **Enterprise Infrastructure**

- **CI/CD**: GitHub Actions with automated testing and validation
- **Documentation**: Comprehensive onboarding and process documentation
- **Sample Data**: Realistic CSV data for development and testing

## Development Workflow

1. **Create Feature Branch**: `git checkout -b feature/your-feature-name`
2. **Develop with AI Assistance**: Use Cursor IDE and Claude integration following memory-bank/ patterns
3. **Test Thoroughly**: Ensure >85% coverage and follow TestDataFactory patterns
4. **Code Review**: Submit PR with AI-assisted code review
5. **Automated Validation**: GitHub Actions validates deployment and runs tests
6. **Deploy**: Merge triggers automated deployment pipeline

## Testing Strategy

### **Unit Tests**

- 85% code coverage requirement with meaningful assertions
- @testSetup patterns for efficient test data creation
- TestDataFactory usage for consistent, reusable test data

### **Integration Tests**

- Cross-system validation using sample data
- API endpoint testing with proper error scenarios
- Performance testing against governor limits

### **AI-Generated Code Validation**

- Automated quality checks for all AI contributions
- Human review requirements for complex changes
- Adherence to enterprise patterns and security guidelines

## AI Integration Guide

### **Memory Bank System**

The memory-bank/ directory maintains persistent AI context:

- **enterprise-patterns.md**: Coding standards and architectural patterns
- **integration-patterns.md**: API and event-driven architecture guidelines
- **project-overview.md**: Business context and technical architecture

### **Cursor IDE Integration**

- Use .cursor/rules/ for project-specific AI behavior
- Reference memory-bank/ files for consistent patterns
- Follow security guidelines for AI tool usage

### **Best Practices**

- Always validate AI-generated code through testing
- Maintain human oversight for architectural decisions
- Update memory bank files with new patterns and learnings

## Contributing

### **Development Standards**

- Follow Salesforce naming conventions and best practices
- Implement comprehensive test coverage (>85%)
- Use descriptive commit messages following [Conventional Commits](https://conventionalcommits.org/)
- Reference existing patterns in memory-bank/ before creating new approaches

### **Code Review Process**

- All changes require peer review
- AI-generated code must be validated by human developers
- Security and performance guidelines must be followed
- Documentation updates required for architectural changes

### **Getting Started**

1. Review [onboarding documentation](https://claude.ai/chat/docs/onboarding/)
2. Set up development environment following prerequisites
3. Read memory-bank/ files to understand project patterns
4. Start with small changes and gradually increase complexity

## Documentation

- [**Architecture Documentation**](https://claude.ai/chat/docs/architecture/) - System design and patterns
- [**AI Integration Guide**](https://claude.ai/chat/docs/ai-integration/) - Claude and Cursor setup
- [**Onboarding Guide**](https://claude.ai/chat/docs/onboarding/) - New developer setup
- [**Testing Documentation**](https://claude.ai/chat/docs/testing/) - Test strategies and patterns

## Support

### **Getting Help**

- **Technical Issues**: [Submit a GitHub issue](https://github.com/CFA-Fintech/AgenticForce-Orchestrator/issues)
- **Documentation**: Check the [docs/ directory](https://claude.ai/chat/docs/)
- **AI Integration**: Review [memory-bank/ files](https://claude.ai/chat/memory-bank/) and [.cursor/rules/](https://claude.ai/chat/cursor/rules/)
- **Salesforce Platform**: [Salesforce Developer Documentation](https://developer.salesforce.com/docs)

### **Community**

- Review existing [issues and discussions](https://github.com/CFA-Fintech/AgenticForce-Orchestrator/issues)
- Contribute improvements via pull requests
- Share feedback and suggestions for enhancement

## License

This project is licensed under the MIT License - see the [LICENSE](https://claude.ai/chat/LICENSE) file for details.

---

**Built with ❤️ for the Salesforce developer community and AI-assisted development workflows.**