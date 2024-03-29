// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { NonceRegistry } from "@/common/NonceRegistry.sol";
import { IPookyball } from "@/pookyball/IPookyball.sol";
import { PookyballReroll } from "@/pookyball/PookyballReroll.sol";

contract DeployPookyballReroll is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address signerAddress = vm.envAddress("BACKEND_ADDRESS");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");

  NonceRegistry nonces = NonceRegistry(vm.envAddress("CONTRACT_NONCE_REGISTRY_ADDRESS"));
  IPookyball pookyball = IPookyball(vm.envAddress("CONTRACT_POOKYBALL_ADDRESS"));

  function run() public {
    // ================ Deploy PookyballReroll ================
    vm.startBroadcast(deployerPK);

    PookyballReroll reroll = new PookyballReroll{ salt: salt }(
      pookyball, nonces, adminAddress, signerAddress, treasuryAddress
    );

    console.log("PookyballReroll deployed at:", address(reroll));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    nonces.grantRole(nonces.OPERATOR(), address(reroll));

    vm.stopBroadcast();
  }
}
