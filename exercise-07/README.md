# Create a parallel running job

In this exercise a third job is created that runs parallel with the 'Second build job'.

## Steps

The following steps should be taken:

- Copy the 'job-102.groovy' file to  'job-103.groovy' in the 'pipeline' directory
- And change the name in the file to 'Third build job' and save the file
- Open the 'job-101.groovy' file in the 'pipeline' directory and change the 'publishers' section into the following.
```groovy
publishers {
	downstreamParameterized {
            trigger('Second build job', 'SUCCESS', true)
            trigger('Third build job', 'SUCCESS', true)
        } 
}
```
- Save the file
- Add, commit and push the changes to the Git repository
- Run the seed-job again, the 'Third build job' should be visible. 
