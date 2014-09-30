# Adding a second build job

In this exercises a second build job is added, this job is triggered after the first job has run successful.

## Steps to create a second build job

The following steps create the second build job:

- Edit the the 'pipeline/job-101.groovy' file add a publisher configuration in the job definition.
```groovy
publishers {
 downstream('Second build job')
}
```
- Create a new file 'job-102.groovy' to the directory 'pipeline'
