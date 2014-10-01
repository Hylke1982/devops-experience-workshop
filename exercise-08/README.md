# Adding a conditional job

In this exercise a conditional 'Fourth build job' will run after both parallel jobs have run.

## Prerequisites

The following components are required to do exercise.

- Jenkins blocking build job plugin

## Steps

The steps to follow to do this exercise.

- Create a 'job-104.groovy' file in the 'pipeline' directory.
- Insert the following content in the file.
```groovy
job {
    name 'Fourth build job'
    blockOn(['Second build job', 'Third build job'])
    blockOnUpstreamProjects()
    scm {
        git('https://github.com/Hylke1982/TDDTrainingApplication', 'devops')
    }
    steps {
        maven('-f TDDTrainingApplicationCC/pom.xml test')
    }
}
```
- Save the file
- Add, commit and push the changes to the Git repository
- Run the 'seed-job' again, the 'Fourth build job' should now be available
![Pipeline view](images/pipeline-view-01)
