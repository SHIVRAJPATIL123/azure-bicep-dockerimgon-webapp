param servicePlanName string
param location string
param sku string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: servicePlanName
  location: location
  sku: {
    name: sku
  }
  properties: {
    reserved: true
}

}
output planid string = appServicePlan.id
