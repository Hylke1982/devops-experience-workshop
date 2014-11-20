# Create a pipeline view

In this exercise a pipeline will be created within the Jenkins installation.

## Prerequisites

The following components need to be installed:

- Pipeline view plugin (is already installed within the Jenkins instance)

## Steps to configure a build pipeline

- Within the TDDTrainingApplication create the 'pipeline.groovy' file within the 'pipeline' directory.
- Insert the following content in the 'pipeline.groovy' file
```groovy
view(type: BuildPipelineView) {
    name('Pipeline')
    description('Continuous delivery build pipeline view')
    filterBuildQueue()
    filterExecutors()
    title('Continuous delivery build pipeline view')
    selectedJob('First build job (compilation)')
    alwaysAllowManualTrigger()
    showPipelineParameters()
    refreshFrequency(60)
}
```
- The pipeline will be installed when run job is clicked for the 'seed-job'
- A pipeline view is added to the jenkins dashboard
![Pipeline view on the default dashboard](images/pipeline-view-01.png)

- You can start the execution of the pipeline by clicking run on the pipeline dashboard
![Example of the most simple pipeline](images/pipeline-view-02.png)
