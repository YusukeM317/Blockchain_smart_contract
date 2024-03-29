// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { BoostPXP } from "@/common/BoostPXP.sol";
import { NonceRegistry } from "@/common/NonceRegistry.sol";
import { Pookyball } from "@/pookyball/Pookyball.sol";

contract DeployPookyball is Script {
  bytes32 salt = keccak256(bytes(vm.envString("SALT")));
  uint256 deployerPK = vm.envUint("DEPLOYER_PK");
  address adminAddress = vm.envAddress("ADMIN_ADDRESS");

  string baseURI = vm.envString("POOKYBALL_BASE_URI");
  string contractURI = vm.envString("POOKYBALL_CONTRACT_URI");

  address royaltyReceiverAddress = vm.envAddress("ROYALTY_RECEIVER_ADDRESS");
  address vrfCoordinatorAddress = vm.envAddress("VRF_COORDINATOR_ADDRESS");
  bytes32 vrfKeyHash = vm.envBytes32("VRF_KEY_HASH");
  uint64 vrfSubId = uint64(vm.envUint("VRF_SUB_ID"));
  uint16 vrfMinimumRequestConfirmations = uint16(vm.envUint("VRF_MINIMUM_REQUEST_CONFIRMATIONS"));
  uint32 vrfCallbackGasLimit = uint32(vm.envUint("VRF_CALLBACK_GAS_LIMIT"));

  function run() public {
    // ================ Deploy Pookyball ================
    vm.startBroadcast(deployerPK);

    Pookyball deployed = new Pookyball{ salt: salt }(
      baseURI,
      contractURI,
      adminAddress,
      royaltyReceiverAddress,
      vrfCoordinatorAddress,
      vrfKeyHash,
      vrfSubId,
      vrfMinimumRequestConfirmations,
      vrfCallbackGasLimit
    );

    console.log("Pookyball deployed at:", address(deployed));

    vm.stopBroadcast();
  }
}
