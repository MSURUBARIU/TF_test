#Intuitive Dev Ops/SRE/SecOps take home challenge
## how to use the code provided:
1. Clone the repo: https://github.com/MSURUBARIU/TF_test
2. I am assuming you already have an AWS account that you are logged into and can be used to deploy the code
3. Make sure the S3 bucket specified in the tf_code/backend.tf file exists, alternatively change it to something that works for you.
4. Make you create the necessary dynamo_db table (this was not dome with TF on purpose as that would require a different process to deploy the environments, using multiple steps, it can of course be arranged in future iterations.)
5. Check the YAML files under the "vars" folder, they define all necessary variables for your environments/regions.
6. cd into the repo/tf_code
7. run terraform init
8. Run terraform workspace new "%env-region%" for any environments you will want to deploy.
9. Run terraform workspace select "%env-region%" for the environment/region you want to deploy.
10. Run terraform plan -out  to use the plan when applying or terraform apply directly.
11. Repeat previous 2 steps to deploy any other environments you need.


## Notes:


General implementation: I tried to keep as much of the core structure as possible while also implementing yaml drive variables.


In order to minimize code duplication I used Terraform workspaces for each environment (qa, staging, prod) I understand this approach has limitations, and depending on how much they will diverge different codebases might need to be used.
Once the modules were functioning for a region I looked at some options on how to minimize code duplication but also keeping things simple. The solution I choose will probably not scale very well, and some other process that will use folders might be needed. At the moment without enough time to polish and try different approaches I will go with different workspaces for each environment/region.  qa-us-east-1, qa-us-west-2, prod-us-east-1 and so on.
Depending on the needs a better folder hierarchy could be environment/account/region/resource_type or region/account/environment/resource_type, or whatever makes sense based on the requirements. At which point it might make more sense to split into separate repos rather than a single huge one. This should be discussed with the stakeholders before starting such a project. There is no one solution that works for everything. In taking the Yaml config workspace approach I merely tried to expose some options of making code easier to write.


Parametrization: Due to the fact I am using the same account(not something you would normally want to do) I had to add extra parameters to account for that.
Network: I kept the network setup simple on purpose, normally we would create public, private and data(accessible only from the private subnet), but would require more time.




Variables inside modules: I try not to use default values unless really necessary since there is a chance you might forget to pass a variable to said module and then wonder why the output is "broken" or not what you would expect. However I understand you provided those defaults as a guideline for variable format.


Lambda: Didn't actually test if it works, might need more work. I should come back to it if time permits.


I understand you wanted to test candidates, but adding a lot of spelling errors that just get caught by tf plan and apply commands and are quite easy to fix, is kind of a waste of time. The exercise is time consuming enough as it is.


Github actions exercise: Unfortunately I will not have enough time to finish this part of the exercise.
I did add some info in the TF_Actions.md as instructed.

## Intoduction
Thank you for taking your time to interview with Intuitive!! For this portion of the interview process, we ask that you complete the challenge in this repository as outlined below. Please give it your best shot! 

Feel free to reach out to the Intuitive team for any clarifications.

We anticipate this task to take about 3 hours. If you feel like the task is taking more than stipulated, feel free to stop and discuss the details with us in the debreif!

## Challenge::

What you have is a Terraform code

Expectation from the TF code is for multi-region and multi-environment deployment capable of::
- staging, qa, prod infrastructure to be deployed in multiple regions
- region specified in the code being [us-east-1, us-west-2], you can choose to change it as per your geogrphical nearness
- TF code should deploy required networking components deployments, along with ec2, s3 and lambda function 
- We would want the recommended best practices to be followed 
- code should be re-usable, structured, scalable, ease of management of the code
- code should be parameterized
- Identify the pitfalls w.r.t to security best practices, recommended code management, gaurd rails, code structure and provide fix 
- You have a sample python function zip into "lambda_pacakge.zip", please only use this package 

## Challenge : GitHub Action 

Now that you have a working TF code which does the required deployment, we would like the execution of TF via GitHub Actions CI/CD pipeline 

- Add a file called "TF-Actions.Md" which outlines the steps to be undertaken to perform the operation 
- Write a pipeline execution file, which will then be triggered from GitHub actions and used to execute the TF code 
- This pipeline should incorporate the best practices involved in a pipeline execution 