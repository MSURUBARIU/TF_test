#Intuitive Dev Ops/SRE/SecOps take home challenge

## Notes:
General implementation: I tried to keep as much of the core structure as possible while also implementing yaml drive variables.

In order to minimise code duplication I used Terraform workspaces for each environment (qa, staging, prod) I understand this approach has limitations, and depending on how much they will diverge different codebases might need to be used. 
Once the modules were functioning for a region I looked at some options on how to minimise code duplication but also keeping things simple. The solution I choose will probably not scale very well, and some other process that will use folders might be needed. At the moment without enough time to polish and try different approaches I will go with different workspaces for each environment/region.  qa-us-east-1, qa-us-west-2, prod-us-east-1 and so on.
Depending on the needs a better folder hierarchy could be environment/account/region/resource_type. At which point it might make more sense to split into reparate repos rather than a huge one. This should be discussed with the stakeholders before starting such a project. There is no one solution that works for everything. In taking the Yaml config workspace approach i meerly tried to expose some options of making code easier to write.

Parametrization: Due to the fact I am using the same account(not something you would normally want to do) I had to add extra parameters to account for that.
Network: I kept the network setup simple on purpose, normally we would create public, private and data(accesible only prom the private subnet), but would require more time.


Variables inside modules: I try not to use default values unless really necessary since there is a chance you might forget to pass a variable to said module and then wonder why the output is "broken" or not what you would expect. However I understand you provided those defaults as a guideline for variable format.

Lambda: Didn't actually test if it works, might need mor work. I should come back to it if time permits.

I understand you wanted to test candidates, but adding a lot of spelling errors that just get cought by tf plan and apply commands and are quite easy to fix, is kind of a waste of time. The exercise is time consuming enough as it is.

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