// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { POK } from "@/tokens/POK.sol";

contract DeployPOK is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");

  function run() public {
    // ================ Deploy POK ================
    vm.startBroadcast(deployerPK);

    POK deployed = new POK{ salt: salt }(adminAddress);

    console.log("POK deployed at:", address(deployed));

    vm.stopBroadcast();
  }
}
