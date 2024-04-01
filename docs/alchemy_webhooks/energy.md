# Energy Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/energy

## Graphql Query

```
{
  block(hash: "0xcd823713b39008f1f6e909103157de6b78d51e22c923bfcd1cab2fa8b5df3092") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Energy
          "0xcE3bAF0c9989beC8e39B0D063Ffdf5C09373a510"
        ]
        topics: [[
          # Transfer(address,address,uint256)
          "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"
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
