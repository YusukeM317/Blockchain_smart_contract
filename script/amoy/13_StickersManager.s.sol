// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { StickersController } from "@/stickers/StickersController.sol";
import { StickersManager } from "@/stickers/StickersManager.sol";

contract DeployStickersManager is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");

  address stickersControllerAddress = vm.envAddress("CONTRACT_STICKERS_CONTROLLER_ADDRESS");
  StickersController controller = StickersController(stickersControllerAddress);

  function run() external {
    // ================ Deploy StickersManager ================
    vm.startBroadcast(deployerPK);

    StickersManager manager = new StickersManager{ salt: salt }(controller);

    console.log("StickersManager deployed at:", address(manager));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("StickerController grant roles for StickerManager");
    controller.grantRoles(address(manager), controller.LINKER() | controller.REPLACER());

    vm.stopBroadcast();
  }
}
