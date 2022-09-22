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
              rowSpan: 4
              colSpan: 6
            }
            metadata: {
              inputs: []
              type: 'Extension[azure]/HubsExtension/PartType/VideoPart'
              settings: {
                content: {
                  settings: {
                    title: ''
                    subtitle: ''
                    src: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ?autoplay=1'
                    autoplay: true
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
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'CpuPercentage'
                          aggregationType: 4
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'CPU Percentage'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'CpuPercentage'
                          aggregationType: 3
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'CPU Percentage'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Avg CPU Percentage and Max CPU Percentage for appservice420'
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
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'MemoryPercentage'
                          aggregationType: 4
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'Memory Percentage'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'MemoryPercentage'
                          aggregationType: 3
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'Memory Percentage'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Avg Memory Percentage and Max Memory Percentage for appservice420'
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
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'DiskQueueLength'
                          aggregationType: 4
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'Disk Queue Length'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'DiskQueueLength'
                          aggregationType: 3
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'Disk Queue Length'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Avg Disk Queue Length and Max Disk Queue Length for appservice420'
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
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'HttpQueueLength'
                          aggregationType: 4
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'Http Queue Length'
                            resourceDisplayName: appServiceName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId(appServiceRG, 'microsoft.web/serverfarms', appServiceName)
                          }
                          name: 'HttpQueueLength'
                          aggregationType: 3
                          namespace: 'microsoft.web/serverfarms'
                          metricVisualization: {
                            displayName: 'Http Queue Length'
                            resourceDisplayName: appServiceName
                          }
                        }
                      ]
                      title: 'Avg Http Queue Length and Max Http Queue Length for appservice420'
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
