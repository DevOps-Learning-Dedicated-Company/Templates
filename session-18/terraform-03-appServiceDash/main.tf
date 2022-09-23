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

variable "appServiceName" {
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
data "azurerm_linux_web_app" "app" {
  name = var.appServiceName
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
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "IoReadOperationsPerSecond",
                        "aggregationType": 1,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "IO Read Operations Per Second",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "HttpResponseTime",
                        "aggregationType": 4,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Response Time",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "HttpResponseTime",
                        "aggregationType": 3,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Response Time",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "RequestsInApplicationQueue",
                        "aggregationType": 4,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Requests In Application Queue",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "RequestsInApplicationQueue",
                        "aggregationType": 3,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Requests In Application Queue",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      }
                    ],
                    "title": "Sum IO Read Operations Per Second, Avg Response Time, and 3 other metrics for ${var.appServiceName}",
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
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "CpuTime",
                        "aggregationType": 1,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "CPU Time",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      }
                    ],
                    "title": "Sum CPU Time for ${var.appServiceName}",
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
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "MemoryWorkingSet",
                        "aggregationType": 4,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Memory working set",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "MemoryWorkingSet",
                        "aggregationType": 3,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Memory working set",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      }
                    ],
                    "title": "Avg Memory working set and Max Memory working set for ${var.appServiceName}",
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
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "Http101",
                        "aggregationType": 1,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Http 101",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "Http2xx",
                        "aggregationType": 1,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Http 2xx",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "Http3xx",
                        "aggregationType": 1,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Http 3xx",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${data.azurerm_linux_web_app.app.id}"
                        },
                        "name": "Http4xx",
                        "aggregationType": 1,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Http 4xx",
                          "resourceDisplayName": "${var.appServiceName}"
                        }
                      }
                    ],
                    "title": "Sum Http 101, Sum Http 2xx, and 2 other metrics for ${var.appServiceName}",
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
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c777184",
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c777196",
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c7771a2",
              "StartboardPart-MonitorChartPart-edce2f42-b144-48db-97d5-c3bf3c7771ae"
            ]
          }
        }
      }
    }
  }
}
DASH
}