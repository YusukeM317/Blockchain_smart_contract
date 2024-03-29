// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { Pookyball } from "@/pookyball/Pookyball.sol";
import { PookyballLevelUp } from "@/pookyball/PookyballLevelUp.sol";
import { POK } from "@/tokens/POK.sol";

contract DeployPookyballLevelUp is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address signerAddress = vm.envAddress("BACKEND_ADDRESS");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");

  Pookyball pookyball = Pookyball(vm.envAddress("CONTRACT_POOKYBALL_ADDRESS"));
  POK pok = POK(vm.envAddress("CONTRACT_POK_ADDRESS"));

  function run() public {
    vm.startBroadcast(deployerPK);

    PookyballLevelUp pookyballLevelUp = new PookyballLevelUp{ salt: salt }(
      pookyball, pok, adminAddress, signerAddress, treasuryAddress
    );

    console.log("PookyballLevelUp deployed at:", address(pookyballLevelUp));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("POK grant roles for PookyballLevelUp");

    pookyball.grantRole(pookyball.GAME(), address(pookyballLevelUp));
    pok.grantRole(pok.BURNER(), address(pookyballLevelUp));

    vm.stopBroadcast();
  }
}
