@description('Name of the existing app service to show in the dashboard')
param appServiceName string

@description('Name of the resource group that contains the app service')
param appServiceRG string

@metadata({ Description: 'Resource name that Azure portal uses for the dashboard' })
param dashboardName string = guid(appServiceName, appServiceRG)

@description('Name of the dashboard to display in Azure portal')
param dashboardDisplayName string = 'Simple App Service Dashboard'
param location string = resourceGroup().location

resource dashboardName_resource 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: dashboardName
  location: location
  tags: {
    'hidden-title': dashboardDisplayName
  }
  properties: {
    lenses: [
      {
        order: 0
        parts: [
          {
            position: {
              x: 0
              y: 0
              colSpan: 6
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'Requests'
                          aggregationType: 1
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Requests'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Sum Requests for${appServiceName}'
                      titleKind: 1
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
          {
            position: {
              x: 6
              y: 0
              colSpan: 6
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'HttpResponseTime'
                          aggregationType: 4
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Response Time'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'HttpResponseTime'
                          aggregationType: 3
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Response Time'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Avg Response Time and Max Response Time for${appServiceName}'
                      titleKind: 1
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 4
              colSpan: 6
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'RequestsInApplicationQueue'
                          aggregationType: 4
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Requests In Application Queue'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'RequestsInApplicationQueue'
                          aggregationType: 3
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Requests In Application Queue'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Avg Requests In Application Queue and Max Requests In Application Queue for${appServiceName}'
                      titleKind: 1
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
          {
            position: {
              x: 6
              y: 4
              colSpan: 6
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'CpuTime'
                          aggregationType: 1
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'CPU Time'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Sum CPU Time for${appServiceName}'
                      titleKind: 1
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 8
              colSpan: 6
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'MemoryWorkingSet'
                          aggregationType: 4
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Memory working set'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'MemoryWorkingSet'
                          aggregationType: 3
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Memory working set'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Avg Memory working set and Max Memory working set for${appServiceName}'
                      titleKind: 1
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
          {
            position: {
              x: 6
              y: 8
              colSpan: 6
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'Http101'
                          aggregationType: 1
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Http 101'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'Http2xx'
                          aggregationType: 1
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Http 2xx'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'Http3xx'
                          aggregationType: 1
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Http 3xx'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'Http4xx'
                          aggregationType: 1
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Http 4xx'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.web/sites', appServiceName)
                          }
                          name: 'Http5xx'
                          aggregationType: 1
                          namespace: 'microsoft.web/sites'
                          metricVisualization: {
                            displayName: 'Http Server Errors'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Sum Http 101, Sum Http 2xx, and 3 other metrics for${appServiceName}'
                      titleKind: 1
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
        ]
      }
    ]
  }
}