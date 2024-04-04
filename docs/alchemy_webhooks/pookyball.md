# Pookyball Alchemy Webhook

## URL

https://blockchain-events-service-t57fod3riq-oa.a.run.app/api/webhook/pookyball

## Graphql Query

```
{
  block(hash: "0x6361d2726ffc5b7ab49a006782513ce2358ab06e4bfd35c9ca1080fa86b2fc00") {
    hash
    number
    timestamp
    logs(
      filter: {
        addresses: [
          # Pookyball
          "0x91290239CD991eB8B748FaFe3fb2401C5ec3c988"
        ]
        topics: [[
          # Seedset(uint256,uint256)
          "0x14296754697e325872a9c14eb682f467bc46b15a78ae9420d7a13a7cd3833b2c"
          # Transfer(uint256,address,address)
          "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"
          # LevelChanged(uint256,uint256)
          "0x8bdaee675270281b7bc2d5b9ced20517ecf5ce96158973ef78072a7bc1491b44"
          # PXPChanged(uint256,uint256)
          "0x334246ed50b046a9933ddd38bbb387c51e3709753687788af1c5207d3689761b"
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
