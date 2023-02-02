param nameseed string = 'dbox'
param location string = resourceGroup().location
param devcenterName string
param environmentName string = 'sandbox'
param catalogName string = 'dcc'
param catalogRepoUri string = 'https://github.com/Gordonby/dev-center-catalog.git'
param catalogRepoPat string = ''

resource dc 'Microsoft.DevCenter/devcenters@2022-11-11-preview' existing = {
  name: devcenterName
}

module kv 'keyvault.bicep' = {
  name: '${deployment().name}-keyvault'
  params: {
    resourceName: nameseed
    location: location
  }
}

module kvSecret 'keyvaultsecret.bicep' = if(!empty(catalogRepoPat)) {
  name: '${deployment().name}-keyvault-patSecret'
  params: {
    keyVaultName: kv.outputs.keyVaultName
    secretName: catalogName
    secretValue: catalogRepoPat
  }
}

resource env 'Microsoft.DevCenter/devcenters/environmentTypes@2022-11-11-preview' = {
  name: environmentName
  parent: dc
}

resource catalog 'Microsoft.DevCenter/devcenters/catalogs@2022-11-11-preview' = {
  name: catalogName
  parent: dc
  properties: {
    gitHub: {
      uri: catalogRepoUri
      branch: 'main'
      secretIdentifier: !empty(catalogRepoPat) ? kvSecret.outputs.secretUri : null
      path: '/Environments'
    }
  }
}
