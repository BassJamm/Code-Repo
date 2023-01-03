param location string = resourceGroup().location

resource stg 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'whdomain${uniqueString(resourceGroup().id)}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_ZRS'
  }
}

output blobUri string = stg.properties.primaryEndpoints.file
