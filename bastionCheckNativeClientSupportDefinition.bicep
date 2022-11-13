targetScope = 'managementGroup'

resource definition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
    name: 'deployBastionTunnelingPolicyDefinition'
    properties: {
        description: 'Identify Bastion hosts that allow TCP tunneling'
        displayName: 'tcpTunnelingEnabledOnBastion'
        metadata: {}
        mode: 'All'
        parameters: {
          effect: {
                type: 'String'
                allowedValues: [
                    'Audit'
                    'Disabled'
                    'Deny'
                ]
          }
        }
        policyRule: {
          if: {
            allOf: [
                {
                    field: 'type'
                    equals: 'Microsoft.Network/BastionHosts'
                }
                {
                    field: 'Microsoft.Network/BastionHosts/enableTunneling'
                    equals: true
                }
            ]
          }
          then: {
            effect: '[parameters(\'effect\')]'
          }
        }
        policyType: 'Custom'
    }
}

