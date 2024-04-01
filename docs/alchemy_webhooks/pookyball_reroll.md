# Pookyball Reroll Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/pookyball/reroll

## Graphql Query

```
{
  block(hash: "0xa9cb852339ea8ac81780d8fd07ab893f4abf88531b182270b232d9062c4bebfe") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Reroll
          "0x5c2E6a21813751411c4d445F9DFa2638c8271f61"
        ]
        topics: [[
          # Reroll(uint256,uint256)
          "0xd49929b567bcaca6fae0329912961a4872c232438a2d478bb94c0775ff1e1f62"
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
