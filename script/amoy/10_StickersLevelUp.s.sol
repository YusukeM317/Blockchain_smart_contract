// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { IStickers } from "@/stickers/Stickers.sol";
import { POK } from "@/tokens/POK.sol";
import { Script } from "forge-std/Script.sol";
import { Stickers } from "@/stickers/Stickers.sol";
import { StickersLevelUp } from "@/stickers/StickersLevelUp.sol";

contract DeployStickersLevelUp is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address signerAddress = vm.envAddress("BACKEND_ADDRESS");

  address royaltyReceiverAddress = vm.envAddress("ROYALTY_RECEIVER_ADDRESS");
  address stickersAddress = vm.envAddress("CONTRACT_STICKERS_ADDRESS");
  POK pok = POK(vm.envAddress("CONTRACT_POK_ADDRESS"));

  function run() external {
    // ================ Deploy StickersLevelUp ================
    vm.startBroadcast(deployerPK);

    StickersLevelUp stickersLevelUp = new StickersLevelUp{ salt: salt }(
      IStickers(stickersAddress), pok, adminAddress, signerAddress, royaltyReceiverAddress
    );

    console.log("StickersLevelUp deployed at:", address(stickersLevelUp));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("POK grant roles for StickersLevelUp");
    pok.grantRole(pok.BURNER(), address(stickersLevelUp));

    vm.stopBroadcast();
  }
}
