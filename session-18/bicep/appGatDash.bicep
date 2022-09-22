@description('Name of the existing application gateway to show in the dashboard')
param appGatName string

@description('Name of the resource group that contains the app gateway')
param appServiceRG string

@metadata({ Description: 'Resource name that Azure portal uses for the dashboard' })
param dashboardName string = guid(appGatName, appServiceRG)

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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'TotalRequests'
                          aggregationType: 1
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Total Requests'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Sum Total Requests for${appGatName}'
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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'FailedRequests'
                          aggregationType: 1
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Failed Requests'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Sum Failed Requests for${appGatName}'
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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'HealthyHostCount'
                          aggregationType: 4
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Healthy Host Count'
                            resourceDisplayName: appGatName
                          }
                        }
                        {
                          resourceMetadata: {
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'UnhealthyHostCount'
                          aggregationType: 4
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Unhealthy Host Count'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Avg Healthy Host Count and Avg Unhealthy Host Count for${appGatName}'
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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'Throughput'
                          aggregationType: 4
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Throughput'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Avg Throughput for${appGatName}'
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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'ApplicationGatewayTotalTime'
                          aggregationType: 4
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Application Gateway Total Time'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Avg Application Gateway Total Time for${appGatName}'
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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'BackendConnectTime'
                          aggregationType: 4
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Backend Connect Time'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Avg Backend Connect Time for${appGatName}'
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
              y: 12
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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'BackendFirstByteResponseTime'
                          aggregationType: 4
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Backend First Byte Response Time'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Avg Backend First Byte Response Time for${appGatName}'
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
              y: 12
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
                            id: resourceId('microsoft.network/applicationgateways', appGatName)
                          }
                          name: 'BackendLastByteResponseTime'
                          aggregationType: 4
                          namespace: 'microsoft.network/applicationgateways'
                          metricVisualization: {
                            displayName: 'Backend Last Byte Response Time'
                            resourceDisplayName: appGatName
                          }
                        }
                      ]
                      title: 'Avg Backend Last Byte Response Time for${appGatName}'
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