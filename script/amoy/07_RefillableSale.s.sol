// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { NonceRegistry } from "@/common/NonceRegistry.sol";
import { Pookyball } from "@/pookyball/Pookyball.sol";
import { RefillableSale } from "@/pookyball/RefillableSale.sol";

contract DeployRefillableSale is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  uint256 adminPK = vm.envUint("ADMIN_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");
  address signerAddress = vm.envAddress("BACKEND_ADDRESS");
  address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");
  address operatorAddress = vm.envAddress("OPERATOR_ADDRESS");

  Pookyball pookyball = Pookyball(vm.envAddress("CONTRACT_POOKYBALL_ADDRESS"));

  function run() public {
    // ================ Deploy RefillableSale ================
    vm.startBroadcast(deployerPK);

    address[] memory sellers = new address[](1);
    sellers[0] = operatorAddress;

    RefillableSale refillableSale =
      new RefillableSale{ salt: salt }(pookyball, treasuryAddress, adminAddress, sellers);

    console.log("RefillableSale deployed at:", address(refillableSale));

    vm.stopBroadcast();

    // ================ Admin grant roles ================
    vm.startBroadcast(adminPK);

    console.log("Pookyball grant roles for RefillableSale to mint");
    pookyball.grantRole(pookyball.MINTER(), address(refillableSale));

    vm.stopBroadcast();
  }
}
