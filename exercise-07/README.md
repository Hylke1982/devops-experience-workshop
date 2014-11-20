# Create a parallel running job

In this exercise a third job is created that runs parallel with the 'Second build job' and this job has the

## Steps

The following steps should be taken:

- Create a new file 'job-003-database-create-sql.groovy'
- Add the following content into this file
```groovy
job {
    name 'Database script creation'
    scm {
        git('https://github.com/Hylke1982/TDDTrainingApplication', 'devops-experience-workshop')
    }
    steps {
        maven('liquibase:updateSQL -pl database')
    }
}
```
- Git add the file to your repository
- Open the 'job-001-compilation.groovy' file in the 'pipeline' directory and change the 'publishers' section into the following.
```groovy
publishers {
	downstreamParameterized {
            trigger('Second build job (unit test)', 'SUCCESS', true)
            trigger('Database script creation', 'SUCCESS', true)
        } 
}
```
- Save the file
- Add, commit and push the changes to the Git repository
- Run the seed-job again, the 'Database script creation' job should be visible in the pipeline.
