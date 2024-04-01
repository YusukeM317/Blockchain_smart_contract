// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { BoostPXP } from "@/common/BoostPXP.sol";
import { NonceRegistry } from "@/common/NonceRegistry.sol";

contract DeployBoostPXP is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address signerAddress = vm.envAddress("BACKEND_ADDRESS");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");

  NonceRegistry nonces = NonceRegistry(vm.envAddress("CONTRACT_NONCE_REGISTRY_ADDRESS"));

  function run() public {
    // ================ Admin grant roles ================
    vm.startBroadcast(deployerPK);

    BoostPXP boostPXP =
      new BoostPXP{ salt: salt }(nonces, adminAddress, signerAddress, treasuryAddress);

    console.log("BoostPXP deployed at:", address(boostPXP));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    nonces.grantRole(nonces.OPERATOR(), address(boostPXP));

    vm.stopBroadcast();
  }
}
