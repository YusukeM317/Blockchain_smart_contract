// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { IPookyball } from "@/pookyball/IPookyball.sol";
import { IStickers } from "@/stickers/Stickers.sol";
import { Script } from "forge-std/Script.sol";
import { StickersController } from "@/stickers/StickersController.sol";

contract DeployStickersController is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");

  address pookyballAddress = vm.envAddress("CONTRACT_POOKYBALL_ADDRESS");
  address stickersAddress = vm.envAddress("CONTRACT_STICKERS_ADDRESS");

  function run() external {
    // ================ Deploy StickersController ================
    vm.startBroadcast(deployerPK);

    StickersController controller = new StickersController{ salt: salt }(
      IPookyball(pookyballAddress), IStickers(stickersAddress), adminAddress
    );

    console.log("StickersController deployed at:", address(controller));

    vm.stopBroadcast();
  }
}
