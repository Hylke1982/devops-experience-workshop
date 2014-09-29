# Exercise 02, Getting a application to deploy

This exercise describes how to get the application we want to deploy.

## Prerequisites

The following items are required for doing this exercise:

- GIT installed
- A GitHub account, if you don't have a account already you can create one [here](https://github.com)

## Getting the application

After you've created a GitHub account, you're now able to fork the application we want to deploy. Forking the application on the GitHub website can be done by doing the following steps:

- Open your GitHub page.
- Goto the [TDDTrainingApplication](https://github.com/co:decentric/TDDTrainingApplication) repository on GitHub
- Fork the application by clicking on the 'fork' button, if you've access to multiple accounts the select the account you want to fork the application to.
- On your local machine goto the location you want to checkout the code.
- Clone the forked application to your machine using the following command.
```
git clone https://github.com/[your-account]/TDDTrainingApplication
```
- Create and checkout the branch 'devops' with the following command and push your branch to remote repository(GitHub)
```
git checkout -b devops
git push origin devops
```
- Create a directory named 'pipeline' in the application directory
