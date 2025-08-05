# Migration Notes

**Migration date:** 2025-08-02 10:42
**Backup source:** AgenticForce-Orchestrator_BACKUP
**New structure:** AgenticForce-Orchestrator

## Summary

This project migrated to an enterprise Salesforce structure, preserving all code, configuration, and AI memory context. File integrity was checked using SHA256; identical files have been confirmed, and all naming differences are noted below.

## Integrity Checks

- All core Apex classes, test files, configs, and CSVs verified identical, unless noted.
- Some files moved to new industry-standard folders (see below).
- No code loss or corruption detected in the migration.

## Naming Differences

- Some files have changed folder locations (e.g., HelloWorld.cls now in force-app/main/default/classes/).
- See integrity check log for details.

## Issues

- Some .cls-meta.xml files appear in both new and old locations—verify no duplication going forward.
- Additional folders were created to match new enterprise standards (no data was lost).
- Please remove any legacy/redundant files if not required.

## Next Steps

- Complete CI/CD setup in .github/workflows/
- Add missing docs to docs/architecture and docs/onboarding
- Review .cursor/rules/memory-bank.mdc and update as needed
- Initialize git if not done: git init; git add .; git commit -m "Initial migration"
