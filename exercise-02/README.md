# Getting a application to deploy

This exercise describes how to get the application we want to deploy.

## Prerequisites

The following items are required for doing this exercise:

- GIT installed
- A GitHub account, if you don't have a account already you can create one [here](https://github.com)
- A SSH key instructions [here](https://help.github.com/articles/generating-ssh-keys)

## Getting the application

After you've created a GitHub account, you're now able to fork the application we want to deploy. Forking the application on the GitHub website can be done by doing the following steps:

- Open your GitHub page.
- Goto the [TDDTrainingApplication](https://github.com/codecentric/TDDTrainingApplication) repository on GitHub
- Fork the application by clicking on the 'fork' button, if you've access to multiple accounts the select the account you want to fork the application to.
- On your local machine goto the location you want to checkout the code.
- Clone the forked application to your machine using the following command.
```sh
git clone https://github.com/[your-account]/TDDTrainingApplication
```
- Checkout the branch 'devops-experience-workshop' with the following command and push your branch to remote repository(GitHub)
```sh
git checkout devops-experience-workshop
```
