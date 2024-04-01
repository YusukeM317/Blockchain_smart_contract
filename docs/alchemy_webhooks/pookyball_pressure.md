# Pookyball Pressure Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/pookyball/pressure

## Graphql Query

```
{
  block(hash: "0xae3c3dabd292cbb43c40afc615d5563a1dfa5f1a92d801a239f361570a519ca5") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Pressure
          "0x3876E098488092af30aFACBF4e99553372CaAedD"
        ]
        topics: [[
          # Inflated(uint256,uint8,uint8)
          "0xae8e536e52847e375aeccd7c0fe477cd7394d10e10101278e98d83ad0633b3da"
        ]]
      }
    ) {
      topics
      data
      index
      account {
        address
      }
      transaction {
        hash
        from {
          address
        }
        value
        status
      }
    }
  }
}
```
