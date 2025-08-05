#!/bin/bash
sf project deploy start --source-dir force-app/main/default --target-org dev-org --test-level RunLocalTests --wait 10
