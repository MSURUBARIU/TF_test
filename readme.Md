#Intuitive Dev Ops/SRE/SecOps take home challenge

## Notes:
General implementation: I tried to keep as much of the core structure as possible while also implementing yaml drive variables.

In order to minimise code duplication I used Terraform workspaces for each environment (qa, staging, prod) I understand this approach has limitations, and depending on how much they will diverge different codebases might need to be used.

Network: I kept the network setup simple on purpose, normally we would create public, private and data(accesible only prom the private subnet), but would require more time.

Outputs: I had to add extra logic in the outputs in order for the output to be different depending on environment.

Variables inside modules: I try not to use default values unless really necessary since there is a chance you might forget to pass a variable to said module and then wonder why the output is "broken" or not what you would expect. However I understand you provided those defaults as a guideline for variable format.

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