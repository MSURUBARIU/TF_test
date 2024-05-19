# Unfortunately, I don't have enough time to finish the pipelines.
# Last time I did some GitHub pipelines was around 1.5 years ago, so putting together and testing
# something I am proud to show will take longer than what I can spend on this now.
# I will include some snippets of pipelines I used in the past, and also send you an article
# about GitLab pipelines. (https://medium.com/globant/implementing-flexible-variable-driven-gitlab-pipelines-21751106b9d7)
# (It's a structure I've used in the past). However, to use a similar structure
# with GitHub Actions you need to do some "weird" things, as last I checked GHA will not let you pass
# variables from one pipeline to another (in a different project). The trick is to use "secrets" to pass those variables.
# Things I would add to a TF pipeline.
# Normally, I would use templates where possible so as not to clutter the project's pipeline unnecessarily.

#     Check if the TF version is the one I want to use.
#     Run Checkov and TFSec checks.
#     Run terraform fmt -check
#     Run terraform validate
#     Run terraform workspace create and select (since in this project we are using that)
#     Run terraform plan and display the output.
#     Terraform apply should be a manual action only (depending on branching strategy this can be part of a merge request process)
#     Confirm apply finished successfully without errors.
