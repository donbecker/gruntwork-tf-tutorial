# gruntwork-tf-part4-infra-live

Completed files for tutorial: https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d

This repo holds composition for each environment (prod or stage) via /(env)/main.tf 

This repo references modules in the gruntwork-tf-part4-infra-mods repo.

State for the environments is kept in S3 and changes are locked via DynamoDB. 

The statelocking resources for each environment are created via /(env)/statelock_init/main.tf


