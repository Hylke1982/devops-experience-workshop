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
    selectedJob('First build job')
    alwaysAllowManualTrigger()
    showPipelineParameters()
    refreshFrequency(60)
}
```
