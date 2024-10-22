param webAppName string
param location string
param planid string
param dockerImage string
param dockerImageTag string

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: webAppName
  location: location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: planid
    siteConfig:{
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVICE_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
      //linuxFxVersion: 'DOCKER|yourACRName.azurecr.io/nginx:latest'
      // Additional Web App configurations
    }
  }
}

output siteUrl string = webApplication.properties.hostNames[0]
