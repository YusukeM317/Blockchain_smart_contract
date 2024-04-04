# Rewards Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/reward

## Graphql Query

```
{
  block(hash: "0x53484e705a10026632c689a082b0723b50c79150acbf634656698a24d2c8c0a7") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Reward
          "0xBa609c15697617f9a243A5E0A609371044497719"
        ]
        topics: [[
          # RewardsClaimed(address,(uint256,uint256,(uint256,uint256)[],uint8[],bytes32[]),string)
          "0x333a6859dbd4f68eb6492cd6f8ad2b4ae4ae870747adebb44935fb4a2603cedf"
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
