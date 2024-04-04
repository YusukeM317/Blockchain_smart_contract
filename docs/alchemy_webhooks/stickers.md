# Stickers Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/sticker

## Graphql Query

```
{
  block(hash: "0x7a71beba18bbcf6c9a057964d613c66c7fd7579a0ebae931b7ce66f80836e478") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Sticker
          "0x975d59D5ff4c1D4ED908892377E23Bf00c40f7aD"
        ]
        topics: [[
          # SeedSet(uint256,uint256)
          "0x14296754697e325872a9c14eb682f467bc46b15a78ae9420d7a13a7cd3833b2c"
          # Transfer(uint256,address,address)
          "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"
          # LevelChanged(uint256,uint256)
          "0x8bdaee675270281b7bc2d5b9ced20517ecf5ce96158973ef78072a7bc1491b44"
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
