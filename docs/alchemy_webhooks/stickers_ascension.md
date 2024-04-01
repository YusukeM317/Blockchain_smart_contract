# Stickers Ascension Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/sticker/ascension

## Graphql Query

```
{
  block(hash: "0xdf758a3c5698d68094e113f25a9ca1a2f7a8d102e9351dea92afbeffc36b7e94") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Ascension Stickers
          "0xCb20FEe5113F10fE06BD9452d2E5cD1972161006"
        ]
        topics: [[
          # Ascended(uint256 indexed tokenId, uint8 rarity, uint256[] parts, string data)
          "0x11869a71baced1026064951c3a99898feaafa2a01af499fe82eb2396891db7ef"
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
