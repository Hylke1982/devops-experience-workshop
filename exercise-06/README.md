# Adding a second build job

In this exercises a second build job is added, this job is triggered after the first job has run successful.

## Steps to create a second build job

The following steps create the second build job:

- Edit the the 'pipeline/job-001-compilation.groovy' file add a publisher configuration in the job definition.
```groovy
job {
    name 'First build job (compilation)'
    scm {
        git('https://github.com/Hylke1982/TDDTrainingApplication', 'devops-experience-workshop')
    }
    steps {
        maven('-f TDDTrainingApplicationCC/pom.xml compile -DskipTests=true')
    }
    publishers {
        downstream('Second build job (unit test)')
    }
}

```
- Create a new file 'job-002-unittest.groovy' to the directory 'pipeline' and insert the following job definition in the file.
```groovy
// Replace 'Hylke1982' within the URL with your own GitHub account
job {
    name 'Second build job (unit test)'
    scm {
        git('https://github.com/Hylke1982/TDDTrainingApplication', 'devops-experience-workshop')
    }
    steps {
        maven('-f TDDTrainingApplicationCC/pom.xml test -DskipTests=false')
    }
    publishers {
        archiveJunit('**/target/surefire-reports/*.xml')
    }
}
```
- Add, commit and push the changes to the Git repositories.
- After running the 'seed-job' again the 'Second build job (unit test)' is now available.
- A extra step is added to the continuous delivery pipeline
- This job will be configured to publish JUnit test reports after running.
![Extra step in the pipeline added](images/pipeline-view-01.png)
