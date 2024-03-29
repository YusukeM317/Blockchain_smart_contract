// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { Energy } from "@/common/Energy.sol";

contract DeployEnergy is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address operatorAddress = vm.envAddress("OPERATOR_ADDRESS");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");

  function run() public {
    // ================ Deploy Energy ================
    vm.startBroadcast(deployerPK);

    address[] memory operators = new address[](1);
    operators[0] = operatorAddress;

    Energy deployed = new Energy{ salt: salt }(adminAddress, operators, treasuryAddress, 5.88 ether);

    console.log("Energy deployed at:", address(deployed));

    vm.stopBroadcast();
  }
}
