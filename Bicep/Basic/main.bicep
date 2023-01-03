param location string = resourceGroup().location

module stgDeploy 'storage.bicep' = {
  name: 'stgDeploy'
  params:{
    namePrefix: 'wh'
    location: location
  }
}
