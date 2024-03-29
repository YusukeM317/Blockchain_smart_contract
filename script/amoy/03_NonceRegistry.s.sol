// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { NonceRegistry } from "@/common/NonceRegistry.sol";

contract DeployNonceRegistry is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  address deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");

  function run() public {
    // ================ Admin grant roles ================
    vm.startBroadcast(deployerPK);

    address[] memory admins = new address[](2);
    admins[0] = deployerAddress;
    admins[1] = adminAddress;

    address[] memory operators = new address[](1);
    operators[0] = deployerAddress;

    NonceRegistry deployed = new NonceRegistry{ salt: salt }(admins, operators);

    console.log("NonceRegistry deployed at:", address(deployed));

    vm.stopBroadcast();
  }
}
