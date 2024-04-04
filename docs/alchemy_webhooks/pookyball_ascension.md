# Pookyball Ascension Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/pookyball/ascension

## Graphql Query

```
{
  block(hash: "0xc0d32f45c8db019a877f8cfe4b021f3adcdb4d9d90dc2942f716155b4e9bbe9d") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Ascension
          "0x1369B4e6B4B1A8f1a6C3c79dCB5DbB251EdC0D30"
        ]
        topics: [[
          # Ascended(uint256,uint8,uint256,uint256,string)
          "0x82c463f27adb1a5c8e7d0209eb97c6dcec687c389dfc71b7c0a6216a128571db"
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
