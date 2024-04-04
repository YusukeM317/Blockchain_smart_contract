# Stickers Controller Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/sticker/controller

## Graphql Query

```
{
  block(hash: "0x40bb2ace6b4d4301747320b9107183def831554b018e0a2a4cdde7199bb8bc6f") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # StickerController
          "0xB9b85d3DCF4bB8c064D9F594354F07F5DCE12daF"
        ]
        topics: [[
          # StickerAttached(uint256,uint256)
          "0xa0caedfb09abf5bb3acfa131de435a0b7aa4884a8b70d261e35fd563f843e1ac"
          # StickerReplaced(uint256,uint256,uint256)
          "0xf22098f7acee83ee20f4856c625c4321d76cb426bcb4e2ae67d7b3eccf00bd85"
          # StickerDetached(uint256,uint256)
          "0x47d2a53d2ac8e763206badd9286235cacd85eb4d108ee384e77c6fedbc4f0f02"
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
