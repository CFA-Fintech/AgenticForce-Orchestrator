# AgenticForce-Orchestrator

**Enterprise-ready Salesforce project template for agentic, AI-assisted workflows (Claude, Cursor, Cline).**

## Quick Start

1. **Clone this repo** (WSL/Ubuntu recommended)
2. `npm install`
3. `sf org login web --alias dev-org`
4. `sf project deploy start --source-dir force-app/main/default --target-org dev-org --test-level RunLocalTests --wait 10`
5. Explore `/force-app/main/default/` for all source code

## Features

- Modern Salesforce DX structure
- Test Data Factory, sample Apex, validation rules, Flow
- LWC boilerplate (`projectCard`)
- Agentic AI context: `.cursor/rules/memory-bank.mdc`, CLAUDE.md ready
- Admin onboarding docs & checklists

## Agentic Setup

- [x] Claude Code & CLI ready
- [x] GitHub Actions / VS Code / Cursor optimized
- [x] Easy migration and WSL workflow

---

*See `/docs/onboarding/` for admin scripts and demo checklist.*

