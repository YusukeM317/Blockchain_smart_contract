// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Pookyball } from "@/pookyball/Pookyball.sol";
import { PookyballAscension } from "@/pookyball/PookyballAscension.sol";
import { Script } from "forge-std/Script.sol";
import { StickersController } from "@/stickers/StickersController.sol";

contract DeployPookyballAscension is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address signerAddress = vm.envAddress("BACKEND_ADDRESS");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");

  address stickersControllerAddress = vm.envAddress("CONTRACT_STICKERS_CONTROLLER_ADDRESS");
  StickersController controller = StickersController(stickersControllerAddress);
  Pookyball pookyball = Pookyball(vm.envAddress("CONTRACT_POOKYBALL_ADDRESS"));

  function run() public {
    // ================ Deploy PookyballAscension ================
    vm.startBroadcast(deployerPK);

    PookyballAscension pookyballAscension = new PookyballAscension{ salt: salt }(
      pookyball, controller, adminAddress, signerAddress, treasuryAddress
    );

    console.log("PookyballAscension deployed at:", address(pookyballAscension));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("Pookyball grant roles for PookyballAscension");
    pookyball.grantRole(pookyball.MINTER(), address(pookyballAscension));

    console.log("StickersController grant roles for PookyballAscension");
    controller.grantRoles(address(pookyballAscension), controller.REMOVER());

    vm.stopBroadcast();
  }
}
