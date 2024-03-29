// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { Stickers } from "@/stickers/Stickers.sol";
import { StickersController } from "@/stickers/StickersController.sol";
import { StickersAscension } from "@/stickers/StickersAscension.sol";

contract DeployStickersAscension is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address signerAddress = vm.envAddress("BACKEND_ADDRESS");

  address stickersAddress = vm.envAddress("CONTRACT_STICKERS_ADDRESS");
  address stickersControllerAddress = vm.envAddress("CONTRACT_STICKERS_CONTROLLER_ADDRESS");
  StickersController controller = StickersController(stickersControllerAddress);
  Stickers stickers = Stickers(stickersAddress);

  function run() public {
    // ================ Deploy StickersAscension ================
    vm.startBroadcast(deployerPK);

    StickersAscension ascension =
      new StickersAscension{ salt: salt }(controller, adminAddress, signerAddress);
    console.log("StickersAscension deployed at:", address(ascension));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("StickersController grant roles for StickersAscension");

    controller.grantRoles(address(ascension), controller.REMOVER());

    console.log("Stickers grant roles for StickersAscension");
    stickers.grantRoles(address(ascension), stickers.MINTER());

    vm.stopBroadcast();
  }
}
