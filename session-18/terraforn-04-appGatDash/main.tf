terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "appGatName" {
  type = string
}
variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "dashboardName" {
  type = string
}

data "azurerm_resource_group" "rg" {
  name = var.rg
}
data "azurerm_application_gateway" "gat" {
  name = var.appGatName
  resource_group_name = var.rg
}


resource "azurerm_portal_dashboard" "my-board" {
  name                = var.dashboardName
  resource_group_name = var.rg
  location            = var.location
  tags = {
    source = "terraform"
  }
  dashboard_properties = <<DASH
{
  "lenses": {
    "0": {
      "order": 0,
      "parts": {
        "0": {
          "position": {
            "x": 0,
            "y": 0,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "TotalRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Total Requests",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "FailedRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Failed Requests",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      }
                    ],
                    "title": "Sum Total Requests and Sum Failed Requests for ${var.appGatName}",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        },
        "1": {
          "position": {
            "x": 6,
            "y": 0,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "HealthyHostCount",
                        "aggregationType": 4,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Healthy Host Count",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "UnhealthyHostCount",
                        "aggregationType": 4,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Unhealthy Host Count",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      }
                    ],
                    "title": "Avg Healthy Host Count and Avg Unhealthy Host Count for ${var.appGatName}",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        },
        "2": {
          "position": {
            "x": 0,
            "y": 4,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "Throughput",
                        "aggregationType": 4,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Throughput",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      }
                    ],
                    "title": "Avg Throughput for ${var.appGatName}",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        },
        "3": {
          "position": {
            "x": 6,
            "y": 4,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "ApplicationGatewayTotalTime",
                        "aggregationType": 4,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Application Gateway Total Time",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "BackendConnectTime",
                        "aggregationType": 4,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Backend Connect Time",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      }
                    ],
                    "title": "Avg Application Gateway Total Time and Avg Backend Connect Time for ${var.appGatName}",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        },
        "4": {
          "position": {
            "x": 0,
            "y": 8,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "BackendFirstByteResponseTime",
                        "aggregationType": 4,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Backend First Byte Response Time",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_application_gateway.gat.id}"
                        },
                        "name": "BackendLastByteResponseTime",
                        "aggregationType": 4,
                        "namespace": "microsoft.network/applicationgateways",
                        "metricVisualization": {
                          "displayName": "Backend Last Byte Response Time",
                          "resourceDisplayName": "${var.appGatName}"
                        }
                      }
                    ],
                    "title": "Avg Backend First Byte Response Time and Avg Backend Last Byte Response Time for ${var.appGatName}",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  },
  "metadata": {
    "model": {
      "timeRange": {
        "value": {
          "relative": {
            "duration": 24,
            "timeUnit": 1
          }
        },
        "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
      },
      "filterLocale": {
        "value": "en-us"
      },
      "filters": {
        "value": {
          "MsPortalFx_TimeRange": {
            "model": {
              "format": "utc",
              "granularity": "auto",
              "relative": "24h"
            },
            "displayCache": {
              "name": "UTC Time",
              "value": "Past 24 hours"
            },
            "filteredPartIds": [
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c777d83",
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c777d95",
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c777da1",
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c777dad",
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c777db9"
            ]
          }
        }
      }
    }
  }
}
DASH
}