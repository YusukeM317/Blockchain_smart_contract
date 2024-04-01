// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { Pressure } from "@/pookyball/Pressure.sol";
import { POK } from "@/tokens/POK.sol";

contract DeployPressure is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");

  POK pok = POK(vm.envAddress("CONTRACT_POK_ADDRESS"));

  function run() public {
    // ================ Deploy Pressure ================
    vm.startBroadcast(deployerPK);

    Pressure pressure = new Pressure{ salt: salt }(pok, treasuryAddress);

    console.log("Pressure deployed at:", address(pressure));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("Pookyball grant roles for Pressure to burn POK");
    pok.grantRole(pok.BURNER(), address(pressure));

    vm.stopBroadcast();
  }
}
