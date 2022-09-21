@description('Name of Application Insights resource.')
param iName string

@description('Type of app you are deploying. This field is for legacy reasons and will not impact the type of App Insights resource you deploy.')
param type string = 'web'
param location string

@description('Source of Azure Resource Manager deployment')
param requestSource string

@description('Test name')
param tName string
param testKind string = 'standard'

@description('hettp request verb (POST, GET, PUT, PATCH or DELETE)')
param httpverb string = 'GET'

@description('URL to test')
param url string

@description('Expected response status code')
param responseCode int

resource iName_resource 'Microsoft.Insights/components@2020-02-02' = {
  name: iName
  location: location
  kind: 'other'
  properties: {
    Application_Type: type
    Flow_Type: 'Bluefield'
    Request_Source: requestSource
  }
}

resource tName_resource 'Microsoft.Insights/webtests@2018-05-01-preview' = {
  name: tName
  location: location
  kind: testKind
  tags: {
    'hidden-link:${iName_resource.id}': 'Resource'
  }
  properties: {
    Configuration: {
      WebTest: 'string'
    }
    Description: 'string'
    Enabled: true
    Frequency: 900
    Kind: testKind
    Locations: [
      {
        Id: 'emea-se-sto-edge'
      }
    ]
    Name: tName
    Request: {
      FollowRedirects: true
      HttpVerb: httpverb
      RequestUrl: url
    }
    RetryEnabled: true
    SyntheticMonitorId: tName
    ValidationRules: {
      ExpectedHttpStatusCode: responseCode
      SSLCertRemainingLifetimeCheck: 7
      SSLCheck: true
    }
  }
}
