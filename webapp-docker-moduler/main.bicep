param webAppName string
param location string
param dockerImage string
param dockerImageTag string
param servicePlanName string
param sku string

module appServicePlan  'modules/appservice.bicep'={
  name:servicePlanName
  params:{
    location:location
    servicePlanName:servicePlanName
    sku:sku
  }
}

module webApplication 'modules/webapp.bicep'={
  name:webAppName
  params:{
    webAppName:webAppName
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
    location: location
    planid: appServicePlan.outputs.planid
  }
}

output siteUrl string = webApplication.outputs.siteUrl
