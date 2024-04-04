// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { Stickers } from "@/stickers/Stickers.sol";
import { StickersSale, Pack, PackContent } from "@/stickers/StickersSale.sol";

contract DeployStickersSale is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");

  address royaltyReceiverAddress = vm.envAddress("ROYALTY_RECEIVER_ADDRESS");
  address stickersAddress = vm.envAddress("CONTRACT_STICKERS_ADDRESS");
  Stickers stickers = Stickers(stickersAddress);

  function run() external {
    Pack[] memory stickersPacks = new Pack[](4);
    stickersPacks[0] = Pack({
      price: 8 ether / 1e6,
      supply: 45,
      minted: 0,
      totalSupply: 45,
      content: PackContent({ common: 2, rare: 0, epic: 0, legendary: 0 })
    });
    stickersPacks[1] = Pack({
      price: 28 ether / 1e6,
      supply: 40,
      minted: 0,
      totalSupply: 40,
      content: PackContent({ common: 3, rare: 1, epic: 0, legendary: 0 })
    });
    stickersPacks[2] = Pack({
      price: 112 ether / 1e6,
      supply: 12,
      minted: 0,
      totalSupply: 12,
      content: PackContent({ common: 8, rare: 1, epic: 1, legendary: 0 })
    });
    stickersPacks[3] = Pack({
      price: 416 ether / 1e6,
      supply: 3,
      minted: 0,
      totalSupply: 3,
      content: PackContent({ common: 16, rare: 2, epic: 1, legendary: 1 })
    });

    // ================ Deploy StickersSale ================
    vm.startBroadcast(deployerPK);

    StickersSale stickersSale =
      new StickersSale{ salt: salt }(stickers, adminAddress, royaltyReceiverAddress, stickersPacks);

    console.log("StickersSale deployed at:", address(stickersSale));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("Stickers grant roles for StickerSale");
    stickers.grantRoles(address(stickersSale), stickers.MINTER());

    vm.stopBroadcast();
  }
}
